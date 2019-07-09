class AddBusinessReferencesToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :business, foreign_key: true
  end
end
