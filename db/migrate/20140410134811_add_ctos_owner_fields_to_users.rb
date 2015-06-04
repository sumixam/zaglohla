class AddCtosOwnerFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :owner_cto_id, :integer
    add_column :users, :owner_cto_confirmed, :boolean
  end
end
