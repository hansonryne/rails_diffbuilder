class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :rules do |t|
      t.references :language, null: false, foreign_key: true
      t.string :category
      t.text :title
      t.text :body
      t.text :more_info_links
      t.string :severity

      t.timestamps
    end
  end
end
