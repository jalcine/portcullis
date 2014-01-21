class AddPayingUserToTransaction < ActiveRecord::Migration
  def change
    add_reference :transactions, :paying_user_id, index: true, default: 0, nil: false
  end
end
