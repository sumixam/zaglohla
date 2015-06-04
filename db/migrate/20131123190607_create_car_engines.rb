class CreateCarEngines < ActiveRecord::Migration
  def change
    create_table :car_engines do |t|
      t.string :name
      t.integer :car_generation_id

      t.timestamps
    end
  end
end
