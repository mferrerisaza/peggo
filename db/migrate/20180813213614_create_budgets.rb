class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.date :start_date
      t.date :end_date
      t.references :building, foreign_key: true

      t.timestamps
    end
  end
end
