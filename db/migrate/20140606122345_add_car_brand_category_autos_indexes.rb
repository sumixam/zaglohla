class AddCarBrandCategoryAutosIndexes < ActiveRecord::Migration
  def change
    add_index :car_brand_category_autos, [:car_brand_id]
    add_index :car_brand_category_autos, [:category_auto_id]
    add_index :car_brand_category_autos, [:category_auto_id, :car_brand_id], name: "car_brand_category_autos_full_index_fields"
  end
end
