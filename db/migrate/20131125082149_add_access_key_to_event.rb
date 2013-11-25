class AddAccessKeyToEvent < ActiveRecord::Migration
  def change
    add_column :events, :access_key, :string
  end
end
