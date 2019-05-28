class AddBuildingToExpense < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenses, :building, foreign_key: true
  end
end
