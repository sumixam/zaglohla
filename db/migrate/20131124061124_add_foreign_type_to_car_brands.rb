class AddForeignTypeToCarBrands < ActiveRecord::Migration
  def change
    add_column :car_brands, :foreigh_type, :boolean
  end
end
