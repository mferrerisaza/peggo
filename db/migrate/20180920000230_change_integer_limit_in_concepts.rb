class ChangeIntegerLimitInConcepts < ActiveRecord::Migration[5.2]
  def change
    change_column :concepts, :amount_paid_cents, :integer, limit: 8
  end
end
