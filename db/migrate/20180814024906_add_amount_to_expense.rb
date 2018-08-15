class AddAmountToExpense < ActiveRecord::Migration[5.2]
  def change
    add_monetize :expenses, :amount, currency: { present: false }
  end
end
