class CtoJobType < ActiveRecord::Base
  belongs_to :cto
  belongs_to :job_type
end
