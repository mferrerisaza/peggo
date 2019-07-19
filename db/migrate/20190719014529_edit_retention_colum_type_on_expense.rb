class EditRetentionColumTypeOnExpense < ActiveRecord::Migration[5.2]
  def change
    change_column :expenses, :retention_cents, :bigint
  end
end
