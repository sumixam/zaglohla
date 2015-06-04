class CarModelsController < ApplicationController
  def index
    render json: CarModel.where(car_brand_id: params[:car_brand_id]).order(:name).all
  end
end
