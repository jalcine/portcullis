class MakeSureThatEventPasswordsAreNeverNil < ActiveRecord::Migration
  def up 
    change_column :events, :password, :string, nil: false, default: ''
  end

  def down
    change_column :events, :password, :string, nil: true, default: nil
  end
end
