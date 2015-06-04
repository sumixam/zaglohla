class UserCtoFav < ActiveRecord::Base
  belongs_to :user
  belongs_to :cto_fav, class_name: "Cto"
end
