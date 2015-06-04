class CreateMechanicUserJobTypes < ActiveRecord::Migration
  def change
    create_table :mechanic_user_job_types do |t|
      t.integer :user_id
      t.integer :job_type_id

      t.timestamps
    end
  end
end
