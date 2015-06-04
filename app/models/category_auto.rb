class CategoryAuto < ActiveRecord::Base
  has_many :car_brand_category_autos
  has_many :car_brands, through: :car_brand_category_autos
end
