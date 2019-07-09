class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.bigint :number
      t.references :contact, foreign_key: true
      t.date :date
      t.string :signature
      t.string :terms_and_conditions
      t.string :notes
      t.string :resolution_number

      t.timestamps
    end
  end
end
