class AddUserLevelIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_level_id, :integer
  end
end
