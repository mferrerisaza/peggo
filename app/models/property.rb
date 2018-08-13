class Property < ApplicationRecord
  enum type: ["Apartamento", "Casa", "Parqueadero"]

  belongs_to :building
  has_many :shares
  has_many :owners, through: :shares

  validates :building_coeficient,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: 1,
              message: "debe ser un valor númerico entre 0 y 100%"
            }

  # TODO: add validations with TDD
end
