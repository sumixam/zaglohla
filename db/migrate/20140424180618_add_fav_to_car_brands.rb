class AddFavToCarBrands < ActiveRecord::Migration
  def change
    add_column :car_brands, :fav, :boolean
  end
end
