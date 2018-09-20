class Concept < ApplicationRecord
  belongs_to :bill

  monetize :amount_cents
  monetize :amount_paid_cents

  validates :description, presence: true
  validates :description, uniqueness: { scope: :bill }
end
