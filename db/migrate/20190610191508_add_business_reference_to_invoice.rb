class AddBusinessReferenceToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :business, foreign_key: true
    add_reference :items, :invoice, foreign_key: true
  end
end
