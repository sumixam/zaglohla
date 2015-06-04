class AddRepairWorkJobIdToRepairCosts < ActiveRecord::Migration
  def change
    add_column :repair_costs, :repair_work_job_id, :integer
  end
end
