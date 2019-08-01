class ExportMailer < ApplicationMailer
  def send_report
    attachments['Reporte.xlsx'] = params[:attachment]
    mail(to: params[:email], subject: "Tu reporte")
  end
end
