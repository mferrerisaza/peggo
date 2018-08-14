class ChangeTypeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :expenses, :type, :category
  end
end
