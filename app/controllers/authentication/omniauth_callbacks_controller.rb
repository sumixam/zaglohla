class Authentication::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token, only: [:facebook, :vkontakte]

  def facebook
    data = request.env["omniauth.auth"]["extra"]["raw_info"]
    email = data["email"] || "#{data["id"]}@fakefacebook.com"
    user = User.find_by_facebook_id(data["id"]) || User.find_by_email(email)
    unless user.present?
      user = User.create({
              email: email,
              password: Devise.friendly_token[0, 20],
              name: data["name"],
              facebook_id: data["id"]
            })
      user.avatar = URI.parse("https://graph.facebook.com/#{data["id"]}/picture?type=large")
      user.save
    end
    sign_in(user)
    redirect_to request.env.fetch('omniauth.params', {})['rpath'] || root_path
  end

  def vkontakte
    data = request.env["omniauth.auth"]["extra"]["raw_info"]
    email = data["email"] || "#{data["id"]}@fakevk.com"
    user = User.find_by_vk_id(data["id"].to_s) || User.find_by_email(email)
    unless user.present?
      user = User.create({
              email: email,
              password: Devise.friendly_token[0, 20],
              name: "#{data["first_name"]} #{data["last_name"]}",
              vk_id: data["id"]
            })
      user.avatar = URI.parse(data["photo_200_orig"])
      user.save
    end
    sign_in(user)
    redirect_to request.env.fetch('omniauth.params', {})['rpath'] || root_path
  end

end
