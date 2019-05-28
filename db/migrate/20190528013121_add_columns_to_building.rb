class AddColumnsToBuilding < ActiveRecord::Migration[5.2]
  def change
    add_column :buildings, :tax_id, :string
    add_column :buildings, :address, :string
    add_column :buildings, :email, :string
    add_column :buildings, :cell_phone, :string
    add_column :buildings, :logo, :string
  end
end
