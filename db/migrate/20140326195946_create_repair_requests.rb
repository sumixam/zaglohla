class CreateRepairRequests < ActiveRecord::Migration
  def change
    create_table :repair_requests do |t|
      t.string :title
      t.text :body
      t.string :email
      t.string :phone
      t.string :name
      t.integer :car_engine_id
      t.integer :car_generation_id
      t.integer :car_model_id
      t.integer :car_brand_id

      t.timestamps
    end
  end
end
