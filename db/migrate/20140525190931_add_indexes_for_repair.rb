class AddIndexesForRepair < ActiveRecord::Migration
  def change
    add_index :car_models, [:car_brand_id]
    add_index :car_generations, [:car_model_id]
    add_index :car_engines, [:car_generation_id]
    add_index :repair_work_jobs, [:repair_work_type_id]
    add_index :repair_work_types, [:repair_work_sector_id]
    add_index :repair_costs, [:repair_work_job_id]
    add_index :repair_costs, [:car_engine_id]
    add_index :repair_costs, [:car_engine_id, :repair_work_job_id]
    add_index :repair_costs, [:car_engine_id, :repair_work_job_id, :repair_work_type_id, :repair_work_sector_id, :car_generation_id, :car_model_id, :car_brand_id], name: "full_index_fields"
  end
end
