class CreateRepairCosts < ActiveRecord::Migration
  def change
    create_table :repair_costs do |t|
      t.integer :repair_work_type_id
      t.integer :repair_work_sector_id
      t.integer :car_generation_id
      t.integer :car_engine_id
      t.integer :car_model_id
      t.integer :car_brand_id
      t.float :hours

      t.timestamps
    end
  end
end
