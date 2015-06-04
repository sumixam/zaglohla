class AddSlugToCarBrands < ActiveRecord::Migration
  def change
    add_column :car_brands, :slug, :string
  end
end
