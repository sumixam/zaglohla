class CreatePayPerHours < ActiveRecord::Migration
  def change
    create_table :pay_per_hours do |t|
      t.string :category_type
      t.integer :car_engine_id
      t.integer :work_type_id

      t.timestamps
    end
  end
end
