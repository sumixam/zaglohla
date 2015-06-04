class CreateMechanicUserSubJobTypes < ActiveRecord::Migration
  def change
    create_table :mechanic_user_sub_job_types do |t|
      t.integer :user_id
      t.integer :sub_job_type_id

      t.timestamps
    end
  end
end
