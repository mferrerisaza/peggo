class DropBillTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :concepts
    drop_table :bills
    drop_table :shares
    drop_table :owners
    drop_table :properties

  end
end
