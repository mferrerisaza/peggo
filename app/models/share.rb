class Share < ApplicationRecord
  belongs_to :property
  belongs_to :owner
  has_many :bills

  validates :ownerability_percentage,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: 1,
              message: "debe ser un valor númerico mayor a 0 y  menor a 100%"
            }
  validates :payment_percentage,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 1,
              message: "debe ser un valor númerico entre 0 y 100%"
            }
end
