class CreateShares < ActiveRecord::Migration[5.2]
  def change
    create_table :shares do |t|
      t.references :property, foreign_key: true
      t.references :owner, foreign_key: true
      t.decimal :ownerability_percentage, precision: 15, scale: 2
      t.decimal :payment_percentage, precision: 15, scale: 2

      t.timestamps
    end
  end
end
