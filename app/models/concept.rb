class Concept < ApplicationRecord
  belongs_to :expense, optional: true
  monetize :amount_cents

  validates :name, :quantity, :amount, :vat, presence: true


  def gross_total
    return unless quantity && amount
    quantity * amount
  end

  def vat_amount
    return unless quantity && amount && vat
    quantity * amount * vat
  end

  def quantity?
    quantity ? quantity : 0
  end

  def vat?
    vat ? vat : 0
  end

  def gross_total?
    amount && quantity ? gross_total : 0
  end
end
