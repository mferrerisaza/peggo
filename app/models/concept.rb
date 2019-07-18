class Concept < ApplicationRecord
  belongs_to :expense, optional: true
end
