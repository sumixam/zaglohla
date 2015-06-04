class AddCustomCarToCtoResponses < ActiveRecord::Migration
  def change
    add_column :cto_responses, :custom_car, :string
  end
end
