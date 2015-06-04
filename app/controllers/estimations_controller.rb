class EstimationsController < ApplicationController

  def index
  end

  def create
    @brand = CarBrand.find_by_id(params[:car_brand_id]) if params[:car_brand_id].present?
    @model = CarModel.find_by_id(params[:car_model_id]) if params[:car_model_id].present?
    @generation = CarGeneration.find_by_id(params[:car_generation_id]) if params[:car_generation_id].present?
    @engine = CarEngine.find_by_id(params[:car_engine_id]) if params[:car_engine_id].present?
    if params[:job_type].present?
      j = params[:job_type].split("-")
      @jt = JobType.find_by_id(j[1]) if j[0] == "j"
      @jt = SubJobType.find_by_id(j[1]) if j[0] == "sj"
    end
    @price = [(rand*10000).round, (rand*10000).round]
  end

end
