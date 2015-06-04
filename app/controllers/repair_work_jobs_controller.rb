class RepairWorkJobsController < ApplicationController
  def index
    render json: RepairWorkJob.where(repair_work_type_id: params[:repair_work_type_id]).all
  end
end
