class AddCustomCarToRepairRequests < ActiveRecord::Migration
  def change
    add_column :repair_requests, :custom_car, :string
  end
end
