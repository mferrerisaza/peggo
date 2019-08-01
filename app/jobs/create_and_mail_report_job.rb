class CreateAndMailReportJob < ApplicationJob
  queue_as :default

  def perform(business_id, user_id, export_params)
    business = Business.find(business_id)
    user = User.find(user_id)

    expenses = retrive_records(:expense, business, export_params)
    invoices = retrive_records(:invoice, business, export_params)
    payments = retrive_records(:payment, business, export_params)
    invoice_equivalents = retrive_records(:invoice_equivalent, business, export_params)
    contacts = retrive_records(:contact, business, export_params)

    excel_file = ApplicationController.render(
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

    ExportMailer.with(email: user.email, attachment: excel_file).send_report.deliver_now
  end

  private

  def retrive_records(symbol, business, args = {})
    return unless args[symbol] == "1"

    model_to_retrieve = symbol.to_s.classify

    if symbol == :contact
      return model_to_retrieve.constantize.where(business: business).where(created_at: args[:dates]).order(id: :desc) unless args[:dates].blank?

      model_to_retrieve.constantize.where(business: business).order(id: :desc)
    else
      return model_to_retrieve.constantize.where(business: business).where(date: args[:dates]).includes(:contact).order(number: :desc) unless args[:dates].blank?

      model_to_retrieve.constantize.where(business: business).includes(:contact).order(number: :desc)
    end
  end
end
