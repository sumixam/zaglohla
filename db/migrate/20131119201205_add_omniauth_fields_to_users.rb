class AddOmniauthFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :string
    add_column :users, :vk_id, :string
  end
end
