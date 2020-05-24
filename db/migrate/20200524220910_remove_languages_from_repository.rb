class RemoveLanguagesFromRepository < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :languages, :repositories
  end
end
