class ChangeResolutionNumberColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :resolution_number, :text
  end
end
