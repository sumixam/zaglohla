class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :city_id, :integer
    add_column :users, :level_state_id, :integer
  end
end
