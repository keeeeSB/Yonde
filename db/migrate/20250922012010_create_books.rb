class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.date :published_date, null: false
      t.text :description, null: false
      t.string :isbn, null: false
      t.integer :page_count, null: false
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
