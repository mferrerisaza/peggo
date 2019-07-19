class DeleteColumnsFromExpense < ActiveRecord::Migration[5.2]
  def change
    remove_column :expenses, :amount_cents
    remove_column :expenses, :description
  end
end
