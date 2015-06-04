class RepairRequest < ActiveRecord::Base
  belongs_to :car_engine
  belongs_to :car_generation
  belongs_to :car_model
  belongs_to :car_brand

  def car_full_name
    name = [car_brand.try(:name), car_model.try(:name), car_generation.try(:name), car_engine.try(:name)].compact.join(" ")
    if name.strip.blank?
      name = custom_car
    end
    name
  end
end
