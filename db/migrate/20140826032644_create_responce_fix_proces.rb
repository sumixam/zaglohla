class CreateResponceFixProces < ActiveRecord::Migration
  def change
    create_table :responce_fix_proces do |t|
      t.integer :cto_response_id
      t.string  :detail
      t.string  :price

      t.timestamps
    end
  end
end
