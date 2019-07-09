class EditTypeOfColumnOnItem < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :price_cents, :bigint
  end
end
