class CreateChildReadingLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :child_reading_logs do |t|
      t.references :child, null: false, foreign_key: true, index: false
      t.references :reading_log, null: false, foreign_key: true

      t.timestamps
    end

    add_index :child_reading_logs, %i[child_id reading_log_id], unique: true
  end
end
