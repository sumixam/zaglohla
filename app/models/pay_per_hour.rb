class PayPerHour < ActiveRecord::Base
  belongs_to :work_type
  belongs_to :car_engine
  belongs_to :cto
end
