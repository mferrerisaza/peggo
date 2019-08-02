class ExportMailer < ApplicationMailer
  def send_report
    business = Business.find(params[:business_id])
    attachments['Reporte.xlsx'] = {
      mime_type: Mime[:xlsx],
      content: build_report(business, params[:export_params])
    }

    mail(
      to: params[:email],
      from: "\"#{business.name} (Peggo)\" <noreply@scuad.co>",
      subject: "Exporta tu información"
    )
  end

  private

  def build_report(business, export_params)
    adjust_dates_for_filters(export_params) unless export_params[:dates].blank?

    expenses = retrive_records(:expense, business, export_params)
    invoices = retrive_records(:invoice, business, export_params)
    payments = retrive_records(:payment, business, export_params)
    invoice_equivalents = retrive_records(:invoice_equivalent, business, export_params)
    contacts = retrive_records(:contact, business, export_params)

    ApplicationController.render(
      template: "exports/create",
      layout: false,
      formats: :xlsx,
      handlers: [:axlsx],
      assigns: {
        business: business,
        expenses: expenses,
        invoices: invoices,
        invoice_equivalents: invoice_equivalents,
        payments: payments,
        contacts: contacts
      }
    )
  end

  def adjust_dates_for_filters(export_params)
    dates = export_params[:dates].split(" a ")
    date_start = Date.parse(dates[0]).midnight

    if dates.size > 1
      date_end = Date.parse(dates[1]).end_of_day
      export_params[:dates] = dates[0]..dates[1]
    else
      date_end = Date.parse(dates[0]).end_of_day
      export_params[:dates] = dates[0]
    end

    export_params[:contact_dates] = date_start..date_end
  end

  def retrive_records(symbol, business, args = {})
    return unless args[symbol] == "1"

    model_to_retrieve = symbol.to_s.classify

    if symbol == :contact
      return model_to_retrieve.constantize.where(business: business).where(created_at: args[:contact_dates]).order(id: :desc) unless args[:contact_dates].blank?

      model_to_retrieve.constantize.where(business: business).order(id: :desc)
    else
      return model_to_retrieve.constantize.where(business: business).where(date: args[:dates]).includes(:contact).order(number: :desc) unless args[:dates].blank?

      model_to_retrieve.constantize.where(business: business).includes(:contact).order(number: :desc)
    end
  end
end
