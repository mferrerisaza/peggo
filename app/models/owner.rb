class Owner < ApplicationRecord
  has_many :shares
  has_many :properties, through: :shares
  belongs_to :user
  belongs_to :building

  validates :name, :email, :card_number, presence: true
  validates :card_number, uniqueness: true
end
