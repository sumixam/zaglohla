class CtoResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :car_engine
  belongs_to :car_brand
  belongs_to :car_model
  belongs_to :car_generation
  belongs_to :cto
  has_many :responce_fix_proces

  accepts_nested_attributes_for :responce_fix_proces, allow_destroy: true

  alias_attribute :was_at, :wat_at

  def car_name
    [car_brand.try(:name), car_model.try(:name)].compact.join(" ")
  end

  def car_full_name
    name = [car_brand.try(:name), car_model.try(:name), car_generation.try(:name), car_engine.try(:name)].compact.join(" ")
    if name.strip.blank?
      name = custom_car
    end
    name
  end
end
