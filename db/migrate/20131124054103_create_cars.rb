class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :user_id
      t.string :category_type
      t.integer :car_engine_id
      t.string :year
      t.string :vin

      t.timestamps
    end
  end
end
