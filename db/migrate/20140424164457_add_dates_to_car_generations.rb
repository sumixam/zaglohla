class AddDatesToCarGenerations < ActiveRecord::Migration
  def change
    add_column :car_generations, :start, :integer
    add_column :car_generations, :ends, :integer
  end
end
