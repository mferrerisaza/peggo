class AddSignatureToBusiness < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :signature, :string
  end
end
