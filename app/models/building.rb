class Building < ApplicationRecord
  belongs_to :user
  has_many :properties
  has_many :budgets
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user }
end
