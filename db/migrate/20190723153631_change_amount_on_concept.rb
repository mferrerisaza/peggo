class ChangeAmountOnConcept < ActiveRecord::Migration[5.2]
  def change
    change_column :concepts, :amount_cents, :bigint
  end
end
