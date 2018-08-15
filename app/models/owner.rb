class Owner < ApplicationRecord
  has_many :shares
  has_many :properties, through: :shares

  validates :name, :email, presence: true
end
