class CreateCtoCarBrands < ActiveRecord::Migration
  def change
    create_table :cto_car_brands do |t|
      t.integer :cto_id
      t.integer :car_brand_id

      t.timestamps
    end
  end
end
