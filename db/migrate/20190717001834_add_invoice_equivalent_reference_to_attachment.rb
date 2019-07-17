class AddInvoiceEquivalentReferenceToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_reference :attachments, :invoice_equivalent, foreign_key: true
  end
end
