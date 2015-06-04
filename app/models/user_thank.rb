class UserThank < ActiveRecord::Base
  belongs_to :user
  belongs_to :thank, class_name: "User"
end
