class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :ticket, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
