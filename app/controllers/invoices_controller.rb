class InvoicesController < ApplicationController

  def new
    @cto = Cto.find params[:cto_id]
    @invoice = Invoice.new
    render layout: false
  end

  def create
    @invoice = Invoice.new(question_params)
    @invoice.save
    UserMailer.invoice(@invoice).deliver
    @cto = Cto.find @invoice.cto_id
    redirect_to cto_path(@cto), flash: { notice: 'invoice' }
  end

  private

  def question_params
    params.require(:invoice).permit(:text, :name, :email, :car_brand_id, :car_engine_id, :car_generation_id, :car_model_id, :cto_id, :phone, :run_km, :view_date, :view_time, :custom_car)
  end
end
