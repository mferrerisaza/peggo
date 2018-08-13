class AddAmountToBudgets < ActiveRecord::Migration[5.2]
  def change
    add_monetize :budgets, :amount, currency: { present: false }
  end
end
