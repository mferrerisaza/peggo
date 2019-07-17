class ChangeAmountAndRetentionOnInvoiceEquivalent < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_equivalents, :amount_cents, :bigint
    change_column :invoice_equivalents, :retention_cents, :bigint
  end
end
