class EditExpenseColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :retention_type, :integer
    add_monetize :expenses, :retention, currency: { present: false }
    remove_column :expenses, :amount_cents
    remove_column :expenses, :description
  end
end
