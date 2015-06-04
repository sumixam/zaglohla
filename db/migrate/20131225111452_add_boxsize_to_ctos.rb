class AddBoxsizeToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :boxsize, :string
    add_column :ctos, :sale_percent, :string
    add_column :ctos, :sale_comment, :string
    add_column :ctos, :contact_person, :string
    add_column :ctos, :intresting_to_work, :integer
  end
end
