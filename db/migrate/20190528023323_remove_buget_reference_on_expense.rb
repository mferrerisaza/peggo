class RemoveBugetReferenceOnExpense < ActiveRecord::Migration[5.2]
  def change
    remove_reference :expenses, :budget
  end
end
