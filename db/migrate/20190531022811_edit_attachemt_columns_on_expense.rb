class EditAttachemtColumnsOnExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :attachments, :json
    remove_column :expenses, :attachment
  end
end
