class CreateUserLevels < ActiveRecord::Migration
  def change
    create_table :user_levels do |t|
      t.string :name

      t.timestamps
    end
  end
end
