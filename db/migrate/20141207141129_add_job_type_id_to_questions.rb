class AddJobTypeIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :job_type_id, :integer
  end
end
