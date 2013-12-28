class AddPublicityToEvents < ActiveRecord::Migration
  def change
    add_column :events, :publicity, :boolean
  end
end
