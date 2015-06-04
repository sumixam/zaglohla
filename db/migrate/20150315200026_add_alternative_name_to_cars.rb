class AddAlternativeNameToCars < ActiveRecord::Migration
  def change
    add_column :cars, :alternative_name, :string
  end
end
