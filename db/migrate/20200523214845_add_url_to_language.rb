class AddUrlToLanguage < ActiveRecord::Migration[6.0]
  def change
    add_column :languages, :url, :text
  end
end
