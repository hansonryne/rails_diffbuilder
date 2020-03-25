class AddSecretPathToRepositories < ActiveRecord::Migration[6.0]
  def change
    add_column :repositories, :secret_path, :string
  end
end
