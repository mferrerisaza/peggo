class ChageAmountIntegerType < ActiveRecord::Migration[5.2]
  def change
    change_column :expenses, :amount_cents, :bigint
  end
end
