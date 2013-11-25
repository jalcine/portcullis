class AddPrimaryCategoryToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :primary_category, index: true
  end
end
