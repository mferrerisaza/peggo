class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.integer :tax_id_type
      t.string :tax_id
      t.boolean :provider
      t.boolean :client
      t.string :phone
      t.string :cell_phone
      t.string :province
      t.string :city
      t.string :address
      t.string :email
      t.references :business, foreign_key: true

      t.timestamps
    end
  end
end
