class CreateUserCtoFavs < ActiveRecord::Migration
  def change
    create_table :user_cto_favs do |t|
      t.integer :user_id
      t.integer :cto_fav_id

      t.timestamps
    end
  end
end
