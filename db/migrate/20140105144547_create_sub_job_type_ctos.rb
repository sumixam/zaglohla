class CreateSubJobTypeCtos < ActiveRecord::Migration
  def change
    create_table :sub_job_type_ctos do |t|
      t.integer :sub_job_type_id
      t.integer :cto_id

      t.timestamps
    end
  end
end
