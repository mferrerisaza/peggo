class Building < ApplicationRecord
  belongs_to :user
  has_many :properties, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_many :owners, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user }

  def building_coeficients_sum
    properties.sum(:building_coeficient)
  end
end
