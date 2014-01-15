class AddChargeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :charge, :decimal, default: 0.00, nil: false
  end
end
