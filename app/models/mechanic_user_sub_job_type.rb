class MechanicUserSubJobType < ActiveRecord::Base
  belongs_to :user
  belongs_to :sub_job_type
end
