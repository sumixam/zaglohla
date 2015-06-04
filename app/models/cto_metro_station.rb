class CtoMetroStation < ActiveRecord::Base
  belongs_to :cto
  belongs_to :metro_station
end
