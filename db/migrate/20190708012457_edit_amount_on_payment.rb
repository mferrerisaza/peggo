class EditAmountOnPayment < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :amount_cents, :bigint
    change_column :payments, :retention_cents, :bigint
  end
end
