class AddNameToCtoResponses < ActiveRecord::Migration
  def change
    add_column :cto_responses, :username, :string
  end
end
