class EditDefaultValuesOfContact < ActiveRecord::Migration[5.2]
  def change
    change_column :contacts, :client, :boolean, default: false
    change_column :contacts, :provider, :boolean, default: false
  end
end
