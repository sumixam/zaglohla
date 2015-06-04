class AddVkPageToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :vk_page, :string
  end
end
