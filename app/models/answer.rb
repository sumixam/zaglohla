class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many   :photos, as: :imageable

  accepts_nested_attributes_for :photos, allow_destroy: true
end
