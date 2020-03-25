class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :repository, null: false, foreign_key: true
      t.date :start_date
      t.string :status
      t.string :owner
      t.string :old_commit
      t.string :new_commit

      t.timestamps
    end
  end
end
