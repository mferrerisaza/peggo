class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.references :share, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
