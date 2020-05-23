class CreateRuleTags < ActiveRecord::Migration[6.0]
  def change
    create_table :rule_tags do |t|
      t.text :name
      t.references :rule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
