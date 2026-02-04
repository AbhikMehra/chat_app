class AddOnlineToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :online, :boolean
  end
end
