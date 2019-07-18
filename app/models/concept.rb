class Concept < ApplicationRecord
  belongs_to :expense, optional: true
  monetize :amount_cents
end
