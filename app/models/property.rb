class Property < ApplicationRecord
  enum property_type: ["Apartamento", "Casa", "Parqueadero"]

  belongs_to :building
  has_many :shares, dependent: :destroy
  has_many :owners, through: :shares
  has_many :bills, through: :shares

  validates :building_coeficient,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: 1,
              message: "debe ser un valor númerico entre 0 y 100%"
            }
  validates :property_type, :name, presence: true

  def full_name
    "#{property_type} #{name}"
  end
end
