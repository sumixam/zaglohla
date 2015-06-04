class CreateCtos < ActiveRecord::Migration
  def change
    create_table :ctos do |t|
      t.string :name
      t.integer :city_id
      t.string :adress_street
      t.string :adress_buildng
      t.string :adress_additional
      t.string :site
      t.string :email
      t.string :icq
      t.string :skype
      t.string :vk_link
      t.string :work_time
      t.text :description
      t.boolean :gov_certificate
      t.boolean :manufacture_certificate

      t.timestamps
    end
  end
end
