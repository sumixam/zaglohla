class ProfilesController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update, :thank]
  before_filter :check_user, only: [:edit, :update]

  respond_to :json, :html

  def index
  end

  def show
    respond_with(@user)
  end

  def edit
  end

  def update
    params = user_params(@user.type.underscore)
    params.delete(:current_password) if params[:current_password].blank?
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?
    act = if params[:current_password].blank? && params[:password].blank? && params[:password_confirmation].blank?
      @user.update_attributes(params)
    else
      @user.update_with_password(params)
    end
    if act
      sign_in :user, @user
      redirect_to profile_path(@user.id)
    else
      render :edit
    end
  end

  def thank
    if current_user.present? && !@user.thanks.include?(current_user)
      @user.thanks << current_user
      @user.save
      @user.change_rating(5)
      current_user.change_rating(1)
    end
    render nothing: true
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def check_user
    redirect_to root_path if current_user.try(:id) != @user.id
  end

  def user_params(type)
    params.require(type.to_sym).permit(:cto_id, :notify_responses, :notify_questions ,:notify_answers, :notify_news, :avatar, :name, :email, :phone, :password, :city_id, :type, :password_confirmation, :description, :mechanic_cto_id, :owner_cto_id, :start_career_year, :current_password)
  end
end
