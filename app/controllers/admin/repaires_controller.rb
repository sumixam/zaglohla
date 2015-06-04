class Admin::RepairesController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  def index
  end

  def calcs
    if params[:car_engine_id].present? && params[:repair_work_job_id].present?
      cost = RepairCost.where(car_engine_id: params[:car_engine_id], repair_work_job_id: params[:repair_work_job_id]).first
      if cost.present?
        text = "#{cost.hours * 500} - #{cost.hours * 1000}"
      else
        text = "Данные не найдены"
      end
    else
      text = "Выберите все параметры"
    end
    render json: { text: text }
  end
end
