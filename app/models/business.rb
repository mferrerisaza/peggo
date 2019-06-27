class Business < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :items, through: :invoices

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user }

  mount_uploader :logo, LogoUploader
end
