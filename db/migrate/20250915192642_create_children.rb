class CreateChildren < ActiveRecord::Migration[8.0]
  def change
    create_table :children do |t|
      t.string :name, null: false
      t.date :birthday, null: false
      t.integer :gender, null: false

      t.timestamps
    end
  end
end
