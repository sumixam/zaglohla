class CtoCarBrand < ActiveRecord::Base
  belongs_to :cto
  belongs_to :car_brand
end
