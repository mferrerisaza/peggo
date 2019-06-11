class Item < ApplicationRecord
  belongs_to :invoice

  validates :name, :quantity, :price, :vat, presence: true
  validates :vat,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: 1,
              message: "debe ser un valor númerico mayor a 0 y  menor a 100%"
            }
  validates :discount,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 1,
              message: "debe ser un valor númerico entre 0 y 100%"
            }

  monetize :price_cents

  def total
    price * (1 + vat) * (1 - discount)
  end
end
