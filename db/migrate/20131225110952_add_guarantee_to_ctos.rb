class AddGuaranteeToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :guarantee, :string
  end
end
