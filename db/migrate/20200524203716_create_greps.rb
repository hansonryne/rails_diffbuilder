class CreateGreps < ActiveRecord::Migration[6.0]
  def change
    create_table :greps do |t|
      t.references :review, null: false, foreign_key: true
      t.references :repository, null: false, foreign_key: true
      t.references :rule, null: false, foreign_key: true
      t.text :results
      t.boolean :custom
      t.text :search_value

      t.timestamps
    end
  end
end
