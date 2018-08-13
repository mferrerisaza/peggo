class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.integer :type
      t.string :name
      t.string :phone
      t.string :matricula_inmobiliaria
      t.decimal :building_coeficient, precision: 15, scale: 2
      t.references :building, foreign_key: true
      t.integer :area
      t.string :address

      t.timestamps
    end
  end
end
