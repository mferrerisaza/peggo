class AddPrintedToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :printed, :boolean, default: false
    add_column :invoices, :printed, :boolean, default: false
    add_column :payments, :printed, :boolean, default: false
    add_column :invoice_equivalents, :printed, :boolean, default: false
  end
end
