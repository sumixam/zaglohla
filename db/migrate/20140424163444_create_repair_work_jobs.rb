class CreateRepairWorkJobs < ActiveRecord::Migration
  def change
    create_table :repair_work_jobs do |t|
      t.string :name
      t.integer :repair_work_type_id

      t.timestamps
    end
  end
end
