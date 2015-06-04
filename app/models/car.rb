class Car < ActiveRecord::Base
  belongs_to :user
  belongs_to :car_engine
  belongs_to :car_brand
  belongs_to :car_model
  belongs_to :car_generation
  has_many   :photos, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :photos, allow_destroy: true

  def name
    [car_brand.try(:name), car_model.try(:name)].compact.join(" ")
  end

  def full_name
    name = [car_brand.try(:name), car_model.try(:name), car_generation.try(:name), car_engine.try(:name)].compact.join(" ")
    if name.empty?
      name = alternative_name || ""
    end
    name
  end

  def nicked_name
    name = full_name
    unless nick.blank?
      name = "#{name} (#{nick})"
    end
    name.truncate(50)
  end

  def main_photo
    photos.first || photos.new
  end
end
