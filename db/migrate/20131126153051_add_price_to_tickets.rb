class AddPriceToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :price, :decimal, precision: 8, scale: 2
  end
end
