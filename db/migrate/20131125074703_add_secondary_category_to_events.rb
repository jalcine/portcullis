class AddSecondaryCategoryToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :secondary_category, index: true
  end
end
