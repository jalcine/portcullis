class RenameAccessKeyToPasswordInEvents < ActiveRecord::Migration
  def change
    rename_column :events, :access_key, :password
  end
end
