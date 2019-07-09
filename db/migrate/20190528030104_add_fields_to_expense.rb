class AddFieldsToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :beneficiary, :string
    add_column :expenses, :payment_method, :integer
  end
end
