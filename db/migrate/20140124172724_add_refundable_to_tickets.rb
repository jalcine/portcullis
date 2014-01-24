class AddRefundableToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :refundable, :boolean, default: true, nil: false
  end
end
