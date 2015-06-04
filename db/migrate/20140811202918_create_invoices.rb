class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :string
      t.integer :car_generation_id
      t.integer :car_engine_id
      t.integer :car_model_id
      t.integer :car_brand_id
      t.string :run_km
      t.integer :cto_id
      t.text :text
      t.string :view_date
      t.string :view_time

      t.timestamps
    end
  end
end
