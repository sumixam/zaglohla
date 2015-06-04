class CarsController < ApplicationController
  def index
    session[:car_highlight] = nil
    @cars = Car.order('created_at DESC')
  end

  def new
    render layout:false
  end

  def create
    @car = Car.new(question_params)
    @car.save
    current_user.change_rating(10)
    redirect_to car_path(@car.id)
  end


  def edit
    @car = Car.find(params[:id])
    render layout:false
  end

  def update
    @car = Car.find(params[:id])
    @car.update_attributes question_params
    redirect_to car_path(@car.id)
  end

  def destroy
    @car = Car.find params[:id]
    if @car.user_id == current_user.try(:id)
      @car.destroy
    end
    render json: {success: true}
  end

  def show
    session[:car_highlight] = nil
    @car = Car.find params[:id]
  end

  private

  def question_params
    params.require(:car).permit(:nick, :description, :user_id, :car_brand_id,
      :year_build, :color, :alternative_name,
      :car_engine_id, :car_generation_id, :car_model_id, :year_start, :runner_km,
      photos_attributes: [:pic])
  end
end
