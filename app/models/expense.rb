class Expense < ApplicationRecord
  before_validation :add_expense_number, on: :create
  belongs_to :building
  enum payment_method: ["Tarjeta Crédito", "Banco", "Otro"]
  monetize :amount_cents
  validates :date, :description, :number,  presence: true
  validates :amount, numericality: { greater_than: 0 }
  has_many :attachments
  accepts_nested_attributes_for :attachments, allow_destroy: true

  def formated_number
    "%03d" % number
  end

  def pdf_file_name
    "CP #{formated_number} #{description}"
  end

  def formated_date
    date.strftime("%d/%m/%Y")
  end

  private

  def add_expense_number
    self.number = building.expenses.size + 1
  end
end
