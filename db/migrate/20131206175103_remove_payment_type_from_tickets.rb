class RemovePaymentTypeFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :payment_type, :integer
  end
end
