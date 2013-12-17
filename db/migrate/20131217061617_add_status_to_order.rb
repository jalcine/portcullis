class AddStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :status, :integer, nil: false, default: 0
  end
end
