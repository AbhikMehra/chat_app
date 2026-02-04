class FixDefaultForUsersOnline < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :online, false
  end
end
