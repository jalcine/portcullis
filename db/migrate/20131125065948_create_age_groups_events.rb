class CreateAgeGroupsEvents < ActiveRecord::Migration
  def change
    create_table :age_groups_events, id: false do |t|
      t.references :event, index: true
      t.references :age_group, index: true
    end
  end
end
