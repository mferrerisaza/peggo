class Building < ApplicationRecord
  belongs_to :user
  has_many :properties, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_many :owners, dependent: :destroy
  has_many :expenses, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user }

  mount_uploader :logo, LogoUploader


  def building_coeficients_sum
    properties.sum(:building_coeficient)
  end

  def area_sum
    properties.sum(:area)
  end

  def active_budget
    budgets.find_by(status: true)
  end
end
