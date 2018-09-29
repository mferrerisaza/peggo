class ChangeScaleOnDecimals < ActiveRecord::Migration[5.2]
  def change
    change_column :properties, :building_coeficient, :decimal, precision: 15, scale: 10
    change_column :shares, :ownerability_percentage, :decimal, precision: 15, scale: 10
    change_column :shares, :payment_percentage, :decimal, precision: 15, scale: 10
  end
end
