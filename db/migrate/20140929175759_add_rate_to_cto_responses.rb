class AddRateToCtoResponses < ActiveRecord::Migration
  def change
    add_column :cto_responses, :rate_cto, :integer
  end
end
