class AddStartFromYearToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :start_from_year, :integer
  end
end
