class Administrator < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable

  bitmask :acl, as: [ :ctos, :users, :questions, :administrators, :services, :job_types, :car_brands ]
end
