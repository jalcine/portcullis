class MakeSureThatProfileAvatarIsNeverNil < ActiveRecord::Migration
  def self.up
    change_column :profiles, :avatar, :string, { default: '', null: false }
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
