class CreateCtoShares < ActiveRecord::Migration
  def change
    create_table :cto_shares do |t|
      t.integer :cto_id
      t.date :from_date
      t.date :to_date
      t.string :description
      t.boolean :anytime

      t.timestamps
    end
  end
end
