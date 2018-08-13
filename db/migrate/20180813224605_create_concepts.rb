class CreateConcepts < ActiveRecord::Migration[5.2]
  def change
    create_table :concepts do |t|
      t.references :bill, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
