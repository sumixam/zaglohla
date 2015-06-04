class AddCarEngineIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :car_engine_id, :integer
  end
end
