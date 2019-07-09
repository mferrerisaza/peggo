class AddObservationsToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :observation, :string
  end
end
