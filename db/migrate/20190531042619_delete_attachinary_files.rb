class DeleteAttachinaryFiles < ActiveRecord::Migration[5.2]
  def change
    drop_table :attachinary_files
  end
end
