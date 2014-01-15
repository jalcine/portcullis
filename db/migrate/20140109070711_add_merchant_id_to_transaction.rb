class AddMerchantIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :merchant_id, :integer
  end
end
