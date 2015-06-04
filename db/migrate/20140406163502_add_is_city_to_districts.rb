class AddIsCityToDistricts < ActiveRecord::Migration
  def change
    add_column :districts, :is_city, :boolean
  end
end
