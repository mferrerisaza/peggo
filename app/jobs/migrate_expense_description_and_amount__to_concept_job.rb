class MigrateExpenseDescriptionAndAmountToConceptJob < ApplicationJob
  queue_as :default

  def perform(expense_id)
    expense = Expense.find(expense_id)
    puts "actualizando #{expense.description}"
    expense.concepts << Concept.create!(
                                        name: expense.description,
                                        quantity: 1,
                                        vat: 0,
                                        amount: expense.amount
                                      )
  end
end
