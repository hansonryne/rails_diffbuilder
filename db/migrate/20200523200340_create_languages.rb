class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.references :repository, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
