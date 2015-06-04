class Admin::EngineBrandsController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @car_engines = CarGeneration.find(params[:ca]).car_engines
    render layout: false
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @car_engine = CarEngine.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @car_engine = CarEngine.new(admin_user_params)
    respond_to do |format|
      if @car_engine.save
        format.html { redirect_to admin_brands_path, notice: 'CarEngine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @car_engine }
      else
        format.html { render action: 'new' }
        format.json { render json: @car_engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @car_engine.update(admin_user_params)
        format.html { redirect_to admin_brands_path, notice: 'CarEngine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @car_engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @car_engine.destroy
    respond_to do |format|
      format.html { redirect_to admin_brands_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @car_engine = CarEngine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:car_engine).permit(:name, :car_generation_id)
    end
end
