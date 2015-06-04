class RepairWorkTypesController < ApplicationController
  def index
    render json: RepairWorkType.where(repair_work_sector_id: params[:repair_work_sector_id]).all
  end
end
