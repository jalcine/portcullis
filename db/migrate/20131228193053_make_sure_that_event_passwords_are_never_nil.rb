class MakeSureThatEventPasswordsAreNeverNil < ActiveRecord::Migration
  def change
    change_column :events, :password, :string, nil: false, default: ''
  end
end
