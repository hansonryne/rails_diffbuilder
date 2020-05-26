class CreateGrepResults < ActiveRecord::Migration[6.0]
  def change
    create_table :grep_results do |t|
      t.text :filename
      t.integer :line_number
      t.references :grep, null: false, foreign_key: true

      t.timestamps
    end
  end
end
