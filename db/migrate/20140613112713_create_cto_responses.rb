class CreateCtoResponses < ActiveRecord::Migration
  def change
    create_table :cto_responses do |t|
      t.integer :user_id
      t.text :text
      t.integer :car_generation_id
      t.integer :car_engine_id
      t.integer :car_model_id
      t.integer :car_brand_id

      t.timestamps
    end
  end
end
