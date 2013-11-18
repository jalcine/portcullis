class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.references :user, index: true
      t.string :token

      t.timestamps
    end
  end
end
