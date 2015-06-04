class CreateCtoJobTypes < ActiveRecord::Migration
  def change
    create_table :cto_job_types do |t|
      t.integer :cto_id
      t.integer :job_type_id

      t.timestamps
    end
  end
end
