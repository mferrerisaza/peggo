class Expense < ApplicationRecord
  # TODO: agregar rubros al expense en el enum de abajo, OJO AL CAMBIAR EL ORDEN
  enum type: ["Aseo", "Seguridad"]
  belongs_to :budget

  # TODO: add validations with TDD
end
