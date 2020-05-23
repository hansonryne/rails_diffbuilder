class CreateRuleTags < ActiveRecord::Migration[6.0]
  def change
    create_table :rule_tags do |t|
      t.belongs_to :rule, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
