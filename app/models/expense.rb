class Expense < ApplicationRecord
  before_validation :add_expense_number, on: :create
  belongs_to :business
  belongs_to :contact
  enum payment_method: ["Efectivo", "Consignación", "Transferencia", "Cheque", "Tarjeta crédito", "Tarjeta débito", "Otro"]
  monetize :amount_cents
  validates :date, :description, :number, :amount,  presence: true
  validates :amount, numericality: { greater_than: 0 }
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  def formated_number
    "%03d" % number
  end

  def pdf_file_name
    "#{formated_number} CE #{description}"
  end

  def formated_date
    date.strftime("%d/%m/%Y")
  end

  private

  def add_expense_number
    self.number = business.expenses.size + 1
  end
end
