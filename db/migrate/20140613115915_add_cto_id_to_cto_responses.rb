class AddCtoIdToCtoResponses < ActiveRecord::Migration
  def change
    add_column :cto_responses, :cto_id, :integer
  end
end
