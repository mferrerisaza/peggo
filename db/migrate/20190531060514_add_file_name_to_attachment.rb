class AddFileNameToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_column :attachments, :file_name, :string
  end
end
