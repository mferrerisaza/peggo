class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :expiration_date, :date
  end
end
