class Bill < ApplicationRecord
  attr_accessor :enviar

  enum status: ["Pagada", "Pendiente"]

  belongs_to :share
  has_many :concepts

  validates :status, presence: true
end
