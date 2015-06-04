class AddCtosMechanicFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mechanic_cto_id, :integer
    add_column :users, :mechanic_cto_confirmed, :boolean
  end
end
