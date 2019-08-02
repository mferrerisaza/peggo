class ExportsController < ApplicationController
  before_action :set_business

  def new
    authorize @business, :business_of_current_user?
  end

  def create
    authorize @business, :business_of_current_user?

    ExportMailer.with(
      email: current_user.email,
      business_id: @business.id,
      export_params: export_params
    ).send_report.deliver_now

    flash[:notice] = "La generación del reporte puede tomar algún tiempo, una vez finalizado lo enviaremos a #{current_user.email}"
    redirect_to new_business_export_path @business
  end

  private

  def export_params
    params.require(:export).permit(
      :dates,
      :expense,
      :invoice,
      :invoice_equivalent,
      :payment,
      :contact
    )
  end
end
