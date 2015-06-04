class CreateManufactureCerts < ActiveRecord::Migration
  def change
    create_table :manufacture_certs do |t|
      t.string :name

      t.timestamps
    end
  end
end
