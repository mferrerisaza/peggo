class RemoveAttachmentsJsonColumnOnExpense < ActiveRecord::Migration[5.2]
  def change
    remove_column :expenses, :attachments
  end
end
