class AddMaxQuantityToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :max_quantity, :integer
  end
end
