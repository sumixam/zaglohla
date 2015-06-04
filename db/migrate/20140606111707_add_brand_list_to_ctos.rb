class AddBrandListToCtos < ActiveRecord::Migration
  def change
    #pg
    #add_column :ctos, :brand_list, :hstore, default: {}
    add_column :ctos, :brand_list, :text
  end
end
