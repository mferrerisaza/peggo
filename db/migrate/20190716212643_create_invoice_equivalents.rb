class CreateInvoiceEquivalents < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_equivalents do |t|
      t.references :business, foreign_key: true
      t.references :contact, foreign_key: true
      t.date :date
      t.bigint :number
      t.text :observation
      t.integer :retention_type
      t.string :description
      t.monetize :amount, currency: { present: false }
      t.monetize :retention, currency: { present: false }

      t.timestamps
    end
  end
end
