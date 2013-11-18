class AddUidToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :uid, :integer
    add_index :providers, :uid, unique: true, order: { uid: :desc }
  end
end
