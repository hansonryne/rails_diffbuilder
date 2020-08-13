class AddCustomToSearchterm < ActiveRecord::Migration[6.0]
  def change
    add_column :searchterms, :custom, :boolean
  end
end
