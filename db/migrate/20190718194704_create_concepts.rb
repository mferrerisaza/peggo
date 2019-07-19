class CreateConcepts < ActiveRecord::Migration[5.2]
  def change
    create_table :concepts do |t|
      t.string :name
      t.integer :quantity
      t.decimal :vat, precision: 15, scale: 10
      t.monetize :amount, currency: { present: false }
      t.references :expense, foreign_key: true

      t.timestamps
    end
  end
end
