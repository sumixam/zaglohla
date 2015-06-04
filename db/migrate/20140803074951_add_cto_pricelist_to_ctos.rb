class AddCtoPricelistToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :cto_pricelist, :text
  end
end
