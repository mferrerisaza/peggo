class Payment < ApplicationRecord
  before_validation :add_payment_number, on: :create

  belongs_to :business
  belongs_to :contact
  belongs_to :invoice , optional: true

  enum payment_method: ["Efectivo", "Consignación", "Transferencia", "Cheque", "Tarjeta crédito", "Tarjeta débito", "Otro"]

  monetize :amount_cents
  monetize :retention_cents

  def formated_number
    "%03d" % number
  end

  def pdf_file_name
    "#{formated_number} RC #{description}"
  end

  def formated_date
    date.strftime("%d/%m/%Y")
  end

  private

  def add_payment_number
    self.number = business.payments.size + 1
  end

end
