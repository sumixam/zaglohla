class CarEngine < ActiveRecord::Base
  has_many :cars, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :pay_per_hours, dependent: :destroy
  belongs_to :car_generation
end
