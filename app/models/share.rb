class Share < ApplicationRecord
  belongs_to :property
  belongs_to :owner
  has_many :bills, dependent: :destroy

  validates :owner, uniqueness: { scope: :property, message: "ya tiene participación en esta propiedad" }
  validates :ownerability_percentage,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: 1,
              message: "debe ser un valor númerico mayor a 0 y  menor a 100%"
            }
  validates :payment_percentage,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 1,
              message: "debe ser un valor númerico entre 0 y 100%"
            }
  def bill_payment
    payment_percentage * property.building_coeficient * owner.building.active_budget.monthly_budget
  end

  def unpaid_bills
    bills.select { |bill| bill.status == "Pendiente" }
  end

  def bills_debt
    return 0 if unpaid_bills.empty?
    unpaid_bills.reduce(0) { |sum, bill| sum + bill.bill_debt }
  end
end
