class Budget < ApplicationRecord
  belongs_to :building
  has_many :expenses
  monetize :amount_cents

  # TODO: add validations with TDD
end
