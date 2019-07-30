class Expense < ApplicationRecord
  before_validation :add_expense_number, on: :create
  belongs_to :business
  belongs_to :contact
  has_many :attachments, dependent: :destroy
  has_many :concepts, dependent: :destroy, index_errors: true

  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :concepts,
                                allow_destroy: true,
                                reject_if: proc { |attributes| attributes['name'].blank? }
  validates :date, :number, presence: true
  validate :retention_is_less_than_concepts_subtotal

  enum payment_method: ["Efectivo",
                        "Consignación",
                        "Transferencia",
                        "Cheque",
                        "Tarjeta crédito",
                        "Tarjeta débito",
                        "Otro"]

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

  monetize :retention_cents

  def formated_number
    format("%03d", number)
  end

  def pdf_file_name
    "#{formated_number} CE #{concepts.map(&:name).join(' - ')}"
  end

  def formated_date
    date.strftime("%d/%m/%Y")
  end

  def concepts_subtotal
    sum = 0
    concepts.each do |concept|
      sum += concept.gross_total if concept.gross_total
    end
    return sum
  end

  def concepts_vat_subtotal
    sum = 0
    concepts.each do |concept|
      sum += concept.vat_amount if concept.vat_amount
    end
    return sum
  end

  def total
    concepts_subtotal + concepts_vat_subtotal - retention
  end

  private

  def add_expense_number
    self.number = business.expenses.size + 1
  end

  def retention_is_less_than_concepts_subtotal
    errors.add(:retention, "supera el subtotal ") if retention > concepts_subtotal
  end
end
