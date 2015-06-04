class CreateCarBrandCategoryAutos < ActiveRecord::Migration
  def change
    create_table :car_brand_category_autos do |t|
      t.integer :car_brand_id
      t.integer :category_auto_id

      t.timestamps
    end
  end
end
