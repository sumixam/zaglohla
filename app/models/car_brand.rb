class CarBrand < ActiveRecord::Base
  has_many :car_models, dependent: :destroy
  has_many :car_brand_category_autos, dependent: :destroy
  has_many :category_autos, through: :car_brand_category_autos

  accepts_nested_attributes_for :car_brand_category_autos, :allow_destroy => true

  before_save :add_slug

  def add_slug
    self.slug = Russian.translit(name).parameterize
  end

  def self.main_brands
    where(id: CarBrandCategoryAuto.where(category_auto_id: [1,2]).map(&:car_brand_id))
  end
end
