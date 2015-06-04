class CreateMechanicUserCarBrands < ActiveRecord::Migration
  def change
    create_table :mechanic_user_car_brands do |t|
      t.integer :user_id
      t.integer :car_brand_id

      t.timestamps
    end
  end
end
