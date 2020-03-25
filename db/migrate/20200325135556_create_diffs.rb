class CreateDiffs < ActiveRecord::Migration[6.0]
  def change
    create_table :diffs do |t|
      t.references :review, null: false, foreign_key: true
      t.string :status
      t.text :notes
      t.string :path
      t.string :reason

      t.timestamps
    end
  end
end
