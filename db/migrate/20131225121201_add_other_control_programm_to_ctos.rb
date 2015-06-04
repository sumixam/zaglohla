class AddOtherControlProgrammToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :other_control_programm, :string
  end
end
