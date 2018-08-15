class ChangeAmountLimit < ActiveRecord::Migration[5.2]
  def change
    change_column :budgets, :amount_cents, :integer, limit: 8
  end
end
