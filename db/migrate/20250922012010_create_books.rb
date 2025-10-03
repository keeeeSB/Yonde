class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.date :published_date
      t.text :description
      t.string :systemid, null: false
      t.integer :page_count
      t.string :image_url

      t.timestamps
    end

    add_index :books, :systemid, unique: true
  end
end
