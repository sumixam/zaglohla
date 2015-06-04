class District < ActiveRecord::Base
  has_many :cto_districts
  before_save :add_slug

  def add_slug
    self.slug = Russian.translit(name).parameterize
  end

  def self.districts
    where(is_city: false)
  end

  def self.cities
    where(is_city: true)
  end
end
