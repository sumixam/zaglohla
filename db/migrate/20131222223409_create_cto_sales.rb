class CreateCtoSales < ActiveRecord::Migration
  def change
    create_table :cto_sales do |t|
      t.string :description
      t.string :salable_type
      t.integer :salable_id
      t.integer :cto_id

      t.timestamps
    end
  end
end
