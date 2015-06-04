class CreateEquipmentCtos < ActiveRecord::Migration
  def change
    create_table :equipment_ctos do |t|
      t.string :title
      t.integer :cto_id
      t.string :mark

      t.timestamps
    end
  end
end
