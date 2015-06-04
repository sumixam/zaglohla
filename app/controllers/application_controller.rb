class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.jsdhgsjkhfgk@ksdhfgskjdfhg.com
  protect_from_forgery with: :exception
#  http_basic_authenticate_with name: "zglhl", password: "JYrioLmc"

  before_filter :configure_permitted_parameters, if: :devise_controller?

  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  def auto_car_create(data)
    return unless current_user.present?
    return if data[:car_engine_id].to_i + data[:car_model_id].to_i + data[:car_generation_id].to_i == 0
    return if current_user.cars.where({
      car_engine_id: data[:car_engine_id],
      car_generation_id: data[:car_generation_id],
      car_model_id: data[:car_model_id],
      car_brand_id: data[:car_brand_id]
    }).count > 0

    session[:car_highlight] = true
    Car.create({
      user_id: current_user.id,
      car_engine_id: data[:car_engine_id],
      car_generation_id: data[:car_generation_id],
      car_model_id: data[:car_model_id],
      car_brand_id: data[:car_brand_id]
    })
    current_user.change_rating(10)
  end

  def default_url_options
    if Rails.env.production?
      {host: "beta.zaglohla.ru"}
    else
      {host: "localhost:3003"}
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :avatar
    devise_parameter_sanitizer.for(:account_update) << :name
  end
end
