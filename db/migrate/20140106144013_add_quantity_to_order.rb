class AddQuantityToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :quantity, :integer, nil: false, default: 0
  end
end
