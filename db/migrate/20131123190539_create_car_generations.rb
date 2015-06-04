class CreateCarGenerations < ActiveRecord::Migration
  def change
    create_table :car_generations do |t|
      t.string :name
      t.integer :car_model_id

      t.timestamps
    end
  end
end
