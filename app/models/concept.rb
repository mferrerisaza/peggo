class Concept < ApplicationRecord
  belongs_to :bill

  monetize :amount_cents
  # TODO: add validations with TDD
end
