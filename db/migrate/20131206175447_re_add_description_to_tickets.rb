class ReAddDescriptionToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :description, :string, null: false, default: ''
  end
end
