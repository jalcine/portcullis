class AddBannerToEvent < ActiveRecord::Migration
  def change
    add_column :events, :banner, :string
  end
end
