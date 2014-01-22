class RenamePayingUserIdIdToPayingUserIdInTransactions < ActiveRecord::Migration
  def change
    rename_column :transactions, :paying_user_id_id, :paying_user_id
  end
end
