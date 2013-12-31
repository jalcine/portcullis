class RemovePasswordsFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :password, :string
  end
end
