class AddNewFieldsToCars < ActiveRecord::Migration
  def change
    add_column :cars, :color, :string
    add_column :cars, :year_build, :string
  end
end
