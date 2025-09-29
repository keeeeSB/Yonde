class CreateLibraryBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :library_books do |t|
      t.references :library, null: false, foreign_key: true, index: false
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    add_index :library_books, %i[library_id book_id], unique: true
  end
end
