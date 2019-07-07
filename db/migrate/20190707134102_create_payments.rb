class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :contact, foreign_key: true
      t.references :invoice, foreign_key: true
      t.bigint :number
      t.date :date
      t.integer :payment_method
      t.string :description
      t.monetize :amount, currency: { present: false }
      t.monetize :retention, currency: { present: false }
      t.text :observation

      t.timestamps
    end
  end
end
