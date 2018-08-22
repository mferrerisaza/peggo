class Owner < ApplicationRecord
  has_many :shares
  has_many :properties, through: :shares

  validates :name, :email, :card_number, presence: true
  validates :card_number, uniqueness: true

  def self.building_owners(building)
    properties = Property.where(building: building)
    shares = properties.map { |e| e.shares }
  end
end
