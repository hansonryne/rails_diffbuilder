class CreateRepositories < ActiveRecord::Migration[6.0]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :project
      t.string :repo_location
      t.string :local_copy

      t.timestamps
    end
  end
end
