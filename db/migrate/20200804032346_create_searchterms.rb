class CreateSearchterms < ActiveRecord::Migration[6.0]
  def change
    create_table :searchterms do |t|
      t.string :value
      t.references :rule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
