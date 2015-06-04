class AddCarFieldsToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :car_brand_id, :integer
    add_column :questions, :car_model_id, :integer
    add_column :questions, :car_generation_id, :integer
  end
end
