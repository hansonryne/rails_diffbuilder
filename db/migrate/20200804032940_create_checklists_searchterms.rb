class CreateChecklistsSearchterms < ActiveRecord::Migration[6.0]
  def change
    create_table :checklists_searchterms do |t|
      t.references :checklist, null: false, foreign_key: true
      t.references :searchterm, null: false, foreign_key: true

      t.timestamps
    end
  end
end
