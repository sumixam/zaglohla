class AddCtoIdToPayPerHours < ActiveRecord::Migration
  def change
    add_column :pay_per_hours, :cto_id, :integer
  end
end
