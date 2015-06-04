class CreatePricelists < ActiveRecord::Migration
  def change
    create_table :pricelists do |t|
      t.integer :cto_id
      t.string :price
      t.text :description
      t.date :checked_at
      t.string :comment

      t.timestamps
    end
  end
end
