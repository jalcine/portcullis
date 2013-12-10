class ChangeTypeOfDescriptionInTicketsFromStringToText < ActiveRecord::Migration
  def change
    change_column :tickets, :description, :text
  end
end
