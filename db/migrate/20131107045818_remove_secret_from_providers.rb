class RemoveSecretFromProviders < ActiveRecord::Migration
  def change
    remove_column :providers, :secret, :string
  end
end
