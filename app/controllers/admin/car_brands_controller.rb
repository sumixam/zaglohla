class Admin::CarBrandsController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @car_brands = CarBrand.all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @car_brand = CarBrand.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @car_brand = CarBrand.new(admin_user_params)

    respond_to do |format|
      if @car_brand.save
        format.html { redirect_to admin_car_brands_path, notice: 'CarBrand was successfully created.' }
        format.json { render action: 'show', status: :created, location: @car_brand }
      else
        format.html { render action: 'new' }
        format.json { render json: @car_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      @car_brand.car_brand_category_autos.destroy_all
      if @car_brand.update(admin_user_params)
        format.html { redirect_to admin_car_brands_path, notice: 'CarBrand was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @car_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @car_brand.destroy
    respond_to do |format|
      format.html { redirect_to admin_car_brands_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @car_brand = CarBrand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:car_brand).permit(:name, :local_brand, :fav, car_brand_category_autos_attributes: [:category_auto_id])
    end
end
