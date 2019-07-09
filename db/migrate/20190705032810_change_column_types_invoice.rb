class ChangeColumnTypesInvoice < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :terms_and_conditions, :text
    change_column :invoices, :notes, :text
  end
end
