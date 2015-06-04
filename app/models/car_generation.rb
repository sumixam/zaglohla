class CarGeneration < ActiveRecord::Base
  belongs_to :car_model
  has_many   :car_engines, dependent: :destroy
end
