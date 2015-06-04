class CreateSpares < ActiveRecord::Migration
  def change
    create_table :spares do |t|
      t.string :manufacture
      t.string :number
      t.string :title
      t.integer :price
      t.string :seller
      t.string :avalaible

      t.timestamps
    end
  end
end
