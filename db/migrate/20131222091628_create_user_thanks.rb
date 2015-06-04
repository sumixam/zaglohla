class CreateUserThanks < ActiveRecord::Migration
  def change
    create_table :user_thanks do |t|
      t.integer :user_id
      t.integer :thank_id

      t.timestamps
    end
  end
end
