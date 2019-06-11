class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.monetize :price, currency: { present: false }
      t.decimal :vat, precision: 15, scale: 10
      t.decimal :discount, precision: 15, scale: 10

      t.timestamps
    end
  end
end
