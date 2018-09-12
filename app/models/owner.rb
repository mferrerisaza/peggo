class Owner < ApplicationRecord
  has_many :shares, dependent: :destroy
  has_many :properties, through: :shares
  has_many :bills, through: :shares
  belongs_to :user
  belongs_to :building

  validates :name, :email, :card_number, presence: true
  validates :card_number, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, message: "no válido"

  def bill_amount
    amounts = shares.map(&:bill_payment)
    amounts.reduce(:+)
  end

  def owner_debt
    shares.reduce(0) {|sum, share| sum + share.bills_debt}
  end
end
