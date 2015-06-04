class CarEnginesController < ApplicationController
  def index
    render json: CarEngine.where(car_generation_id: params[:car_generation_id]).all
  end
end
