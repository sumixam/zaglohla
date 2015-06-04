class CreateCtoServices < ActiveRecord::Migration
  def change
    create_table :cto_services do |t|
      t.integer :cto_id
      t.integer :service_id

      t.timestamps
    end
  end
end
