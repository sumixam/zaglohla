class MetroStationsController < ApplicationController
  def index
    render json: MetroStation.where(city_id: params[:city_id]).all
  end
end
