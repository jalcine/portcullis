class ChangeTypeOfUidFromIntegerToStringInProviders < ActiveRecord::Migration
  def change
    change_column :providers, :uid, :string
  end
end
