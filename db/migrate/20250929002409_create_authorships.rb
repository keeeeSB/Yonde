class CreateAuthorships < ActiveRecord::Migration[8.0]
  def change
    create_table :authorships do |t|
      t.references :author, null: false, foreign_key: true, index: false
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    add_index :authorships, %i[author_id book_id], unique: true
  end
end
