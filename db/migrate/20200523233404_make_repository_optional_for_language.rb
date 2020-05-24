class MakeRepositoryOptionalForLanguage < ActiveRecord::Migration[6.0]
  def change
    change_column_null :languages, :repository_id, true
  end
end
