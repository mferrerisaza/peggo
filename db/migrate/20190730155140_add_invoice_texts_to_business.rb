class AddInvoiceTextsToBusiness < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :invoice_terms_and_conditions, :text
    add_column :businesses, :invoice_notes, :text
    add_column :businesses, :invoice_resolution_number, :text
  end
end
