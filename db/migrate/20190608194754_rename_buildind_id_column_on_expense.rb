class RenameBuildindIdColumnOnExpense < ActiveRecord::Migration[5.2]
  def change
    rename_column :expenses, :building_id, :business_id
  end
end
