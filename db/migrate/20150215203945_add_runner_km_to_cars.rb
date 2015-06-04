class AddRunnerKmToCars < ActiveRecord::Migration
  def change
    add_column :cars, :runner_km, :string
  end
end
