class CreateGuaranteeCtos < ActiveRecord::Migration
  def change
    create_table :guarantee_ctos do |t|
      t.integer :cto_id
      t.string :length
      t.string :comment

      t.timestamps
    end
  end
end
