class SubJobTypeCto < ActiveRecord::Base
  belongs_to :sub_job_type
  belongs_to :cto
end
