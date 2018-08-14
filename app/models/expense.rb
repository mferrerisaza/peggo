class Expense < ApplicationRecord
  # TODO: agregar rubros al expense en el enum de abajo, OJO AL CAMBIAR EL ORDEN
  enum category: ["Aseo", "Seguridad"]
  belongs_to :budget

  monetize :amount_cents

  validates :date, :description, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
