class AddBankColumnsToContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :account_number, :string
    add_column :contacts, :account_type, :integer
    add_column :contacts, :account_bank, :integer
  end
end
