class DeleteBudgetTable < ActiveRecord::Migration[5.2]
  def change
    # drop_table :budgets
    rename_table :buildings, :businesses
  end
end
