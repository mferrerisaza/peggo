class AddMonthToBill < ActiveRecord::Migration[5.2]
  def change
    add_column :bills, :period, :string
  end
end
