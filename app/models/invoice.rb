class Invoice < ApplicationRecord
  before_validation :add_invoice_number, on: :create

  belongs_to :business
  belongs_to :contact
  has_many :items, dependent: :nullify, inverse_of: :invoice
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

  def formated_number
    "%03d" % number
  end

  def pdf_file_name
    "Factura de venta num #{formated_number}"
  end

  def formated_date
    date.strftime("%d/%m/%Y")
  end

  def items_gross_subtotal
    sum = 0
    items.each do |item|
      sum += item.gross_total
    end
    return sum
  end

  def items_discount_subtotal
    sum = 0
    items.each do |item|
      sum -= item.discount_amount
    end
    return sum
  end

  def items_vat_subtotal
    sum = 0
    items.each do |item|
      sum += item.vat_amount
    end
    return sum
  end

  def items_net_subtotal
    items_gross_subtotal + items_discount_subtotal
  end

  def total
    items_net_subtotal + items_vat_subtotal
  end

  private

  def add_invoice_number
    self.number = business.invoices.size + 1
  end
end
