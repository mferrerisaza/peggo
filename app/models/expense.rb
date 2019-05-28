class Expense < ApplicationRecord
  belongs_to :building
  monetize :amount_cents
  validates :date, :description, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
