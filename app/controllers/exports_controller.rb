class ExportsController < ApplicationController
  before_action :set_business

  def new
    authorize @business, :business_of_current_user?
  end

  def create
    authorize @business, :business_of_current_user?
    CreateAndMailReportJob.perform_now(
      @business.id,
      current_user.id,
      export_params
    )
    flash[:notice] = "La generación del reporte puede tomar algún tiempo, una vez finalizado lo enviaremos a #{current_user.email}"
    redirect_to new_business_export_path @business
  end

  private

  def export_params
    strong_params = params.require(:export).permit(
      :dates,
      :expense,
      :invoice,
      :invoice_equivalent,
      :payment,
      :contact
    )
    unless strong_params[:dates].blank?
      dates = strong_params[:dates].split(" a ")
      strong_params[:dates] = dates[0]..dates[1]
    end
    strong_params
  end
end
