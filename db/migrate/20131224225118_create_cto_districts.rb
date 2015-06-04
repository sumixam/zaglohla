class CreateCtoDistricts < ActiveRecord::Migration
  def change
    create_table :cto_districts do |t|
      t.integer :cto_id
      t.integer :district_id

      t.timestamps
    end
  end
end
