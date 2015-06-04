class CreateCtoCategoryAutos < ActiveRecord::Migration
  def change
    create_table :cto_category_autos do |t|
      t.integer :cto_id
      t.integer :category_auto_id

      t.timestamps
    end
  end
end
