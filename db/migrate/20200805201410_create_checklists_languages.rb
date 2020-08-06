class CreateChecklistsLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :checklists_languages do |t|
      t.references :checklist, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
