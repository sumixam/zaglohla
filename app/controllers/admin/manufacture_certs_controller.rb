class Admin::ManufactureCertsController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @manufacture_certs = ManufactureCert.all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @manufacture_cert = ManufactureCert.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @manufacture_cert = ManufactureCert.new(admin_user_params)

    respond_to do |format|
      if @manufacture_cert.save
        format.html { redirect_to admin_manufacture_certs_path, notice: 'ManufactureCert was successfully created.' }
        format.json { render action: 'show', status: :created, location: @manufacture_cert }
      else
        format.html { render action: 'new' }
        format.json { render json: @manufacture_cert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @manufacture_cert.update(admin_user_params)
        format.html { redirect_to admin_manufacture_certs_path, notice: 'ManufactureCert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @manufacture_cert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @manufacture_cert.destroy
    respond_to do |format|
      format.html { redirect_to admin_manufacture_certs_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @manufacture_cert = ManufactureCert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:manufacture_cert).permit(:name)
    end
end
