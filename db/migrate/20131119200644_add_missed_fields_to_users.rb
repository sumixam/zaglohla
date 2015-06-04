class AddMissedFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rating, :float
    add_column :users, :cto_id, :integer
    add_column :users, :start_career_year, :integer
  end
end
