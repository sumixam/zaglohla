class AddWobToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :work_with_other_brands, :boolean
  end
end
