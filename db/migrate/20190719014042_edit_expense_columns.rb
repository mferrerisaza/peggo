class EditExpenseColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :retention_type, :integer
    add_monetize :expenses, :retention, currency: { present: false }
  end
end
