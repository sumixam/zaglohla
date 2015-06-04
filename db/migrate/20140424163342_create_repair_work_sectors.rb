class CreateRepairWorkSectors < ActiveRecord::Migration
  def change
    create_table :repair_work_sectors do |t|
      t.string :name

      t.timestamps
    end
  end
end
