class AddOfficialDilerToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :official_diler, :boolean
  end
end
