class AddRetentionDescriptionToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :retention_type, :integer
  end
end
