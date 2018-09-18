class BillsController < ApplicationController
  before_action :set_building, only: %i[show new create errors]

  def show
  end

  def new
    check_bill_conditions
    authorize @building, :building_of_current_user?
    @owners = @building.owners
  end

  def create
    authorize @building, :building_of_current_user?
    params[:bills].each do |owner|
      next unless owner[:enviar].present?
      create_bill(owner_params(owner), bill_params(params))
    end
    redirect_to building_path(@building)
  end

  def errors
    authorize @building, :building_of_current_user?
  end

  private

  def check_bill_conditions
    failing_conditions = {}
    failing_conditions[:presupuesto_activo] = true unless @building.active_budget
    failing_conditions[:coeficientes_de_copropiedad] = true unless @building.building_coeficients_sum == 1
    failing_conditions[:porcentajes_de_pago] = true unless @building.properties.all? { |property| property.payment_sum == 1 }

    render_bill_creation_errors(failing_conditions) if failing_conditions.any? { |_k, v| v }
  end

  def render_bill_creation_errors(conditions = {})
    conditions.each do |k, _v|
      if k == :presupuesto_activo
        conditions[k] = ["No hay un presupuesto activo sobre el cual calcular la cuota.", building_budgets_path(@building)]
      elsif k == :coeficientes_de_copropiedad
        conditions[k] = ["Los coefientes de la copropiedad no suman 100%.", building_properties_path(@building)]
      elsif k == :porcentajes_de_pago
        conditions[k] = ["Una o varias propiedades tienen porcentajes de pago que no suman 100%.", building_properties_path(@building)]
      end
    end
    @messages = conditions
    render 'errors'
  end

  def owner_params(params)
    params.permit(:enviar, :owner_id)
  end

  def bill_params(params)
    params.permit(:bill_period)[:bill_period]
  end

  def create_bill(owner_params, bill_period)
    @owner = Owner.find(owner_params[:owner_id])
    @owner.shares.each do |share|
      next if share.payment_percentage.zero?
      Bill.create(share: share, status: "Pendiente", period: bill_period)
    end
  end
end
