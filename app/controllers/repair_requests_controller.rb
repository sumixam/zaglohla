class RepairRequestsController < ApplicationController

  def create
    @repair_request = RepairRequest.new(repair_request_params)
    @repair_request.save
    UserMailer.repair_request(@repair_request).deliver
    redirect_to root_path, flash: { notice: 'invoice' }
  end

  def new
    render layout: false
  end

  private

  def repair_request_params
    params.require(:repair_request).permit(:title, :body, :email, :phone, :name,
      :car_engine_id, :car_generation_id, :car_model_id, :car_brand_id, :custom_car)
  end
end
