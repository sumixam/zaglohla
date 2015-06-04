class AddAdministratorIdToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :administrator_id, :integer
  end
end
