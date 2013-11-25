class CreateEventAgeGroups < ActiveRecord::Migration
  def change
    create_table :event_age_groups, id: false do |t|
      t.references :event, index: true
      t.references :age_group, index: true
    end
    
    add_index :event_age_groups, [:event_id, :age_group_id]
    add_index :event_id, :age_group_id
  end
end
