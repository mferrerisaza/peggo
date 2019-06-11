class Business < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user }

  mount_uploader :logo, LogoUploader
end
