class RepairWorkSector < ActiveRecord::Base
  has_many :repair_work_types, dependent: :destroy
end
