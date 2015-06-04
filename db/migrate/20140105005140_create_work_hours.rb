class CreateWorkHours < ActiveRecord::Migration
  def change
    create_table :work_hours do |t|
      t.string :weekday_start
      t.string :time_start
      t.string :weekday_finish
      t.string :time_finish
      t.integer :cto_id

      t.timestamps
    end
  end
end
