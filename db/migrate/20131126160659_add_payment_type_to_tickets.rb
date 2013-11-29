class AddPaymentTypeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :payment_type, :integer
  end
end
