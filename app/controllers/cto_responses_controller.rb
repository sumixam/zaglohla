class CtoResponsesController < ApplicationController

  def new
    @cto = Cto.find params[:cto_id]
    @response = CtoResponse.new
    render layout: false
  end

  def create
    if current_user.present?
      @response = CtoResponse.new(question_params)
      @response.save
      @cto = Cto.find @response.cto_id
      @response.rate_cto = star_for_cto(current_user, @cto)
      @response.save
      gflash notice: {
        time: 3000,
        value: "Ваша отзыв добавлен",
        title: "Спасибо",
        image: false,
        position: :bottom_right
      }
      current_user.change_rating(15)
      redirect_to "/ctos/#{@cto.id}#tabs|cto-tabs:tabs-4"
    else
      if user = User.find_by_email(user_params["email"])
        sign_in(user)
        @response = CtoResponse.new(question_params)
        @response.user_id = user.id
        @response.save
        @cto = Cto.find @response.cto_id
        @cto.rate params[:score], user, "quality"
        @response.rate_cto = star_for_cto(user, @cto)
        @response.save
        gflash notice: {
          time: 3000,
          value: "Ваша отзыв добавлен",
          title: "Спасибо",
          image: false,
          position: :bottom_right
        }
        user.change_rating(15)
        redirect_to "/ctos/#{@cto.id}#tabs|cto-tabs:tabs-4"
      else
        password = SecureRandom.hex 6
        user = User.create(email: user_params["email"], name: user_params["name"], password: password)
        sign_in(user)
        UserMailer.response_registration(user.email, password).deliver
        @response = CtoResponse.new(question_params)
        @response.user_id = user.id
        @response.save
        @cto = Cto.find @response.cto_id
        @cto.rate params[:score], user, "quality"
        @response.rate_cto = star_for_cto(user, @cto)
        @response.save
        user.change_rating(15)
        redirect_to "/ctos/#{@cto.id}#tabs|cto-tabs:tabs-4", flash: { notice: 'response_registration' }
      end
    end
  end

  private

  def star_for_cto(user, cto)
    Rate.where(rater_id: user.id, rateable_id: cto.id, dimension: "quality", rateable_type: "Cto").first.try(:stars).to_i
  end

  def question_params
    params.require(:cto_response).permit(
      :text, :user_id, :username, :car_brand_id, :car_engine_id,
      :car_generation_id, :car_model_id, :cto_id, :was_at, :custom_car,
      responce_fix_proces_attributes: [:detail, :price, :cto_response_id]
    )
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
