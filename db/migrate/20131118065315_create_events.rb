class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :date_start
      t.datetime :date_end

      t.timestamps
    end
  end
end
