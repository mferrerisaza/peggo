class AddAmountToConcepts < ActiveRecord::Migration[5.2]
  def change
    add_monetize :concepts, :amount, currency: { present: false }
  end
end
