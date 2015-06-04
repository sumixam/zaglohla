class AddAlternativeNameToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :alternative_name, :string
  end
end
