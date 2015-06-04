class AddCoordsToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :lat, :string
    add_column :ctos, :lon, :string
  end
end
