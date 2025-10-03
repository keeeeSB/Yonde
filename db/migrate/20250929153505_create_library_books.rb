class CreateLibraryBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :library_books do |t|
      t.references :family_library, null: false, foreign_key: true, index: false
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    add_index :library_books, %i[family_library_id book_id], unique: true
  end
end
