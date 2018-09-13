class BillsController < ApplicationController
  before_action :set_building, only: %i[new create errors]

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
    conditions = {}
    conditions[:active_budget] = false if @building.active_budget
    conditions[:building_coeficients] = false if @building.building_coeficients_sum == 1
    conditions[:properties_payment_sum] = false if @building.properties.all? { |property| property.payment_sum == 1 }

    render_bill_creation_errors(conditions) if conditions.any? { |_k, v| v == false }
  end

  def render_bill_creation_errors(conditions = {})
    redirect_to bills_errors_building_path(@building)
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
