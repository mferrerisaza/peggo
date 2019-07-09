class EditNameOfFileNameColumnOnAttachment < ActiveRecord::Migration[5.2]
  def change
    rename_column :attachments, :file_name, :name
  end
end
