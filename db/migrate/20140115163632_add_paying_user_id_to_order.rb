class AddPayingUserIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :paying_user_id, :integer, default: 0, nil: false
  end
end
