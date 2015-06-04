class AddSlugToMetroStations < ActiveRecord::Migration
  def change
    add_column :metro_stations, :slug, :string
  end
end
