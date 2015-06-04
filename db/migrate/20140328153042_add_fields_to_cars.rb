class AddFieldsToCars < ActiveRecord::Migration
  def change
    add_column :cars, :description, :string
    add_column :cars, :text, :string
    add_column :cars, :nick, :string
    add_column :cars, :year_start, :integer
    add_column :cars, :car_generation_id, :integer
    add_column :cars, :car_model_id, :integer
    add_column :cars, :car_brand_id, :integer
  end
end
