class CreateFamilyLibraries < ActiveRecord::Migration[8.0]
  def change
    create_table :family_libraries do |t|
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
