class Admin::BrandsController < Admin::ApplicationController
  # before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @cas = CategoryAuto.includes(car_brands: {car_models: {car_generations: :car_engines}})
    render stream: true
  end

  def rmall
    (params[:engines] || []).each{|e| CarEngine.find_by_id(e).try(:destroy) }
    (params[:generations] || []).each{|e| CarGeneration.find_by_id(e).try(:destroy) }
    (params[:models] || []).each{|e| CarModel.find_by_id(e).try(:destroy) }
    (params[:brands] || []).each{|e| CarBrand.find_by_id(e).try(:destroy) }
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_admin_user
    #   @car_brand = CarBrand.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def admin_user_params
    #   params.require(:car_brand).permit(:name, :local_brand, :fav, car_brand_category_autos_attributes: [:category_auto_id])
    # end
end
