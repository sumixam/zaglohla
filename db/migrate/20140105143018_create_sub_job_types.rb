class CreateSubJobTypes < ActiveRecord::Migration
  def change
    create_table :sub_job_types do |t|
      t.string :name
      t.integer :job_type_id

      t.timestamps
    end
  end
end
