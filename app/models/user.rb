class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: {
      medium: "175x147>",
      thumb: "50x50>"
    }, default_url: "/images/users/:style.png",
    url: "/system/users/:attachment/:id/:style/:basename.:extension",
    path: ":rails_root/public/system/users/:attachment/:id/:style/:basename.:extension"

  belongs_to :city
  belongs_to :user_level
  has_many :cars
  has_many :user_thanks
  has_many :thanks, through: :user_thanks, class_name: "User"
  has_many :user_cto_favs
  has_many :cto_favs, through: :user_cto_favs, class_name: "Cto"
  has_many :questions
  has_many :answers
  has_many :cto_responses
  belongs_to :mechanic_cto, class_name: "Cto"
  belongs_to :owner_cto, class_name: "Cto"
  belongs_to :cto, class_name: "Cto"
  has_many :mechanic_user_car_brands
  has_many :mechanic_car_brands, through: :mechanic_user_car_brands, class_name: "CarBrand"
  has_many :mechanic_user_job_types
  has_many :mechanic_job_types, through: :mechanic_user_job_types, class_name: "JobType"
  has_many :mechanic_user_sub_job_types
  has_many :mechanic_sub_job_types, through: :mechanic_user_sub_job_types, class_name: "SubJobType", source: "SubJobType"

  after_save :reset_confimrations
  after_create :add_reg_rating

  letsrate_rater

  def user_type
    "Пользователь"
  end

  def last_question
    questions.where(visible: true).order('created_at DESC').limit(5)
  end

  def last_answer
    answers.order('created_at DESC').limit(5)
  end

  def last_repsonse
    cto_responses.order('created_at DESC').limit(5)
  end

  def mycar
    cars.first
  end

  def social_account?
    facebook_id.present? || vk_id.present?
  end

  def fake_mail?
    email.include?("fakefacebook") || email.include?("fakevk")
  end

  def current_email
    fake_mail? ? "" : email
  end

  def change_rating(number)
    self.rating = (self.rating || 0) + number
    self.rating = 0 unless self.rating.present?
    self.user_level_id = case
      when self.rating < 30
        UserLevel.find(1).id
      when self.rating >= 30 && self.rating < 60
        UserLevel.find(2).id
      else
        UserLevel.find(3).id
    end
    self.save
  end

  private

  def reset_confimrations
    User.where(id: id).update_all(mechanic_cto_confirmed: false) if mechanic_cto_id_changed?
    User.where(id: id).update_all(owner_cto_confirmed: false) if owner_cto_id_changed?
    if cto_id.present?
        Cto
          .where(id: cto_id)
          .update_all({expert_rating: User.where(cto_id: cto_id, type: "Mechanic").pluck(:rating).map(&:to_i).sum})
    end
  end

  def add_reg_rating
    change_rating(15)
    unless fake_mail?
      UserMailer.welcome(self).deliver
    end
  end
end
