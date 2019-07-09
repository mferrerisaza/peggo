class RemoveCategoryFromExpense < ActiveRecord::Migration[5.2]
  def change
    remove_column :expenses, :category
  end
end
