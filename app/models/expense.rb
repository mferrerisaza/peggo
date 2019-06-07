class Expense < ApplicationRecord
  belongs_to :building
  enum payment_method: ["Tarjeta Crédito", "Banco", "Otro"]
  monetize :amount_cents
  validates :date, :description, presence: true
  validates :amount, numericality: { greater_than: 0 }
  has_many :attachments
  accepts_nested_attributes_for :attachments
end
