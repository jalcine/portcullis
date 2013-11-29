class AddDateEndToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :date_end, :datetime
  end
end
