class CreateCtoMetroStations < ActiveRecord::Migration
  def change
    create_table :cto_metro_stations do |t|
      t.integer :cto_id
      t.integer :metro_station_id

      t.timestamps
    end
  end
end
