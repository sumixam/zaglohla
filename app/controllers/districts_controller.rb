class DistrictsController < ApplicationController
  def index
    render json: District.where(city_id: params[:city_id]).all
  end
end
