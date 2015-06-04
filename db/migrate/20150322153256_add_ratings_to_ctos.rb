class AddRatingsToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :rating, :integer, default: 100
    add_column :ctos, :expert_rating, :integer, default: 0
  end
end
