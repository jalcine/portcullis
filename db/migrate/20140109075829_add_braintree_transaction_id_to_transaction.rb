class AddBraintreeTransactionIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :braintree_transaction_id, :string
  end
end
