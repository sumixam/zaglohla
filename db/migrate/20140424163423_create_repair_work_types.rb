class CreateRepairWorkTypes < ActiveRecord::Migration
  def change
    create_table :repair_work_types do |t|
      t.string :name
      t.integer :repair_work_sector_id

      t.timestamps
    end
  end
end
