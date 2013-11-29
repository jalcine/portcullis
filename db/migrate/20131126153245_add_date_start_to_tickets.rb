class AddDateStartToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :date_start, :datetime
  end
end
