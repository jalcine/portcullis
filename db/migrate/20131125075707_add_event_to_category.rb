class AddEventToCategory < ActiveRecord::Migration
  def change
    add_reference :categories, :event, index: true
  end
end
