class AddAdditionalPhonesToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :additional_phone_1, :string
    add_column :ctos, :additional_phone_2, :string
    add_column :ctos, :additional_phone_3, :string
  end
end
