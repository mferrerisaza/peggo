class Payment < ApplicationRecord
  belongs_to :business
  belongs_to :contact
  belongs_to :invoice , optional: true

  monetize :amount_cents
  monetize :retention_cents

end
