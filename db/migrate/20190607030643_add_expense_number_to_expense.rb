class AddExpenseNumberToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :number, :bigint
  end
end
