class EditObservationTypeOnExpense < ActiveRecord::Migration[5.2]
  def change
    change_column :expenses, :observation, :text
  end
end
