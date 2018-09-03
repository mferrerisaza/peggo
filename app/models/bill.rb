class Bill < ApplicationRecord

  enum status: ["Pagada", "Pendiente"]

  belongs_to :share
  has_many :concepts

  validates :status, presence: true
end
