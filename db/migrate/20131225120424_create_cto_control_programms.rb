class CreateCtoControlProgramms < ActiveRecord::Migration
  def change
    create_table :cto_control_programms do |t|
      t.integer :cto_id
      t.integer :control_programm_id

      t.timestamps
    end
  end
end
