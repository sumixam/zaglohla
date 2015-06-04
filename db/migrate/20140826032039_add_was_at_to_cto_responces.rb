class AddWasAtToCtoResponces < ActiveRecord::Migration
  def change
    add_column :cto_responses, :wat_at, :date
  end
end
