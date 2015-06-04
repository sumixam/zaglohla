class RepairWorkType < ActiveRecord::Base
  has_many :repair_work_jobs, dependent: :destroy
  belongs_to :repair_work_sector
end
