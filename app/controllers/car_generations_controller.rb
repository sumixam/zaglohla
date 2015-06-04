class CarGenerationsController < ApplicationController
  def index
    render json: CarGeneration.where(car_model_id: params[:car_model_id]).order('start desc').all
  end
end
