class CreateFamilyLibraries < ActiveRecord::Migration[8.0]
  def change
    create_table :family_libraries do |t|
      t.references :book, null: false, foreign_key: true, index: false
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end

    add_index :family_libraries, %i[book_id family_id], unique: true
  end
end
