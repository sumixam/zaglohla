class AddSignOnTimeToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :sign_on_time, :boolean
  end
end
