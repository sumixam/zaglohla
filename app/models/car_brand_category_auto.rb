class CarBrandCategoryAuto < ActiveRecord::Base
  belongs_to :car_brand
  belongs_to :category_auto
end
