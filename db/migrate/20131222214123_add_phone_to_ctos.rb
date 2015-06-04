class AddPhoneToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :phone, :string
  end
end
