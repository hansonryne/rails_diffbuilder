class AddLanguageArrayToRepositories < ActiveRecord::Migration[6.0]
  def change
    add_column :repositories, :languages, :text
  end
end
