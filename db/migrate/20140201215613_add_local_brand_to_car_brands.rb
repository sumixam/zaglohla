class AddLocalBrandToCarBrands < ActiveRecord::Migration
  def change
    add_column :car_brands, :local_brand, :boolean
  end
end
