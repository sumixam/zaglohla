class Admin::MetroStationsController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @metro_stations = MetroStation.all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @metro_station = MetroStation.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @metro_station = MetroStation.new(admin_user_params)

    respond_to do |format|
      if @metro_station.save
        format.html { redirect_to admin_metro_stations_path, notice: 'MetroStation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @metro_station }
      else
        format.html { render action: 'new' }
        format.json { render json: @metro_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @metro_station.update(admin_user_params)
        format.html { redirect_to admin_metro_stations_path, notice: 'MetroStation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @metro_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @metro_station.destroy
    respond_to do |format|
      format.html { redirect_to admin_metro_stations_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @metro_station = MetroStation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:metro_station).permit(:name)
    end
end
