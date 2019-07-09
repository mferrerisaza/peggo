class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.integer :type
      t.date :date
      # t.references :budget, foreign_key: true
      t.string :description
      t.string :attachment

      t.timestamps
    end
  end
end
