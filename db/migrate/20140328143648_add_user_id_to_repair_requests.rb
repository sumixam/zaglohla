class AddUserIdToRepairRequests < ActiveRecord::Migration
  def change
    add_column :repair_requests, :user_id, :integer
    add_column :repair_requests, :proccessed, :boolean
  end
end
