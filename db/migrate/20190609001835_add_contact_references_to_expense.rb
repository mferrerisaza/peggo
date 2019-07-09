class AddContactReferencesToExpense < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenses, :contact, foreign_key: true
    remove_column :expenses, :beneficiary
  end
end
