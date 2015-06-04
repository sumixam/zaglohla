class AddOtherJobTypesToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :other_job_types, :string
  end
end
