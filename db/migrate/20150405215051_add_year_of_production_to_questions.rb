class AddYearOfProductionToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :year_of_production, :integer
  end
end
