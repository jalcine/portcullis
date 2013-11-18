class AddSecretToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :secret, :string
    add_index :providers, :secret, unique: true
  end
end
