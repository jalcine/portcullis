class MakeChargesIntoCentsForOrders < ActiveRecord::Migration
  def change
    Order.all.each { |o| o.charge *= 100 }
    change_column :orders, :charge, :integer
  end
end
