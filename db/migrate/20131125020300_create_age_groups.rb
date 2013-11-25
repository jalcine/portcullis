class CreateAgeGroups < ActiveRecord::Migration
  def change
    create_table :age_groups do |t|
      t.string :name
      t.integer :max_age
      t.integer :min_age

      t.timestamps
    end
  end
end
