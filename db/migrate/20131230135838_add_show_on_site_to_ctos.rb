class AddShowOnSiteToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :show_on_site, :boolean
  end
end
