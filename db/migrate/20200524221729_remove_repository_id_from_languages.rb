class RemoveRepositoryIdFromLanguages < ActiveRecord::Migration[6.0]
  def change
    remove_column :languages, :repository_id
  end
end
