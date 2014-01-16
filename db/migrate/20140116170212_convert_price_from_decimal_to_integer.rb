class ConvertPriceFromDecimalToInteger < ActiveRecord::Migration
  def change
    change_column :tickets, :price, :integer, nil: false, default: 0
  end
end
