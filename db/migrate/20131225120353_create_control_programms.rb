class CreateControlProgramms < ActiveRecord::Migration
  def change
    create_table :control_programms do |t|
      t.string :name

      t.timestamps
    end
  end
end
