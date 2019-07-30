class InvoiceEquivalent < ApplicationRecord
  before_validation :add_invoice_equivalent_number, on: :create
  belongs_to :business
  belongs_to :contact

  monetize :amount_cents
  monetize :retention_cents

  enum retention_type: ["Arrendamiento de bienes muebles - (4%)",
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
                        "Transporte de carga - (1%)"]

  validates :date, :description, :number, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  def formated_number
    format("%03d", number)
  end

  def pdf_file_name
    "#{formated_number} DE #{description}"
  end

  def formated_date
    date.strftime("%d/%m/%Y")
  end

  def total
    amount - retention
  end

  def retention_full_name
    return unless retention

    if retention_type && retention
      "#{ActionController::Base.helpers.humanized_money_with_symbol retention} - #{retention_type}"
    elsif retention
      "#{ActionController::Base.helpers.humanized_money_with_symbol retention}"
    end
  end

  private

  def add_invoice_equivalent_number
    self.number = business.invoice_equivalents.size + 1
  end
end
