class Payment < ApplicationRecord
  before_validation :add_payment_number, on: :create
  validate :amount_is_less_than_debt


  belongs_to :business
  belongs_to :contact
  belongs_to :invoice , optional: true

  enum payment_method: ["Efectivo", "Consignación", "Transferencia", "Cheque", "Tarjeta crédito", "Tarjeta débito", "Otro"]
  enum retention_type: [
                        "Arrendamiento de bienes muebles - (4%)",
                        "Arrendamiento de bienes raíces - (3.5%)",
                        "Compras - (2.5%)",
                        "Compras - (3.5%)",
                        "Honorarios y comisiones - (10%)",
                        "Honorarios y comisiones - (11%)",
                        "Servicios de aseo y vigilancia - (2%)",
                        "Servicios de hoteles y restaurantes - (3.5%)",
                        "Servicios en general - (4%)",
                        "Servicios en general - (6%)",
                        "ReteICA - (0%)",
                        "ReteIVA - (15%)",
                        "Transporte de carga - (1%)"
                      ]

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

  def total
    amount + retention
  end

  def retention_full_name
    return unless retention

    if retention_type && retention
      "#{retention_type}: #{ActionController::Base.helpers.humanized_money_with_symbol retention}"
    elsif retention
      "#{ActionController::Base.helpers.humanized_money_with_symbol retention}"
    end
  end

  private

  def add_payment_number
    self.number = business.payments.size + 1
  end

  def amount_is_less_than_debt
    return unless invoice
    debt_amount = invoice.debt + ((amount_cents_was + retention_cents_was)/100).to_money
    errors.add(:amount, "la suma de retención y valor recibido supera la deuda ") if total > debt_amount
  end

end
