class Admin::AdministratorsController < ApplicationController
  before_action :set_admin_administrator, only: [:show, :edit, :update, :destroy]
  layout "admin"
  # GET /admin/administrators
  # GET /admin/administrators.json
  def index
    @admin_administrators = Administrator.all
  end

  # GET /admin/administrators/1
  # GET /admin/administrators/1.json
  def show
  end

  # GET /admin/administrators/new
  def new
    @admin_administrator = Administrator.new
  end

  # GET /admin/administrators/1/edit
  def edit
  end

  # POST /admin/administrators
  # POST /admin/administrators.json
  def create
    @admin_administrator = Administrator.new(admin_administrator_params)

    respond_to do |format|
      if @admin_administrator.save
        format.html { redirect_to admin_administrators_url, notice: 'Administrator was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_administrator }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/administrators/1
  # PATCH/PUT /admin/administrators/1.json
  def update
    opts = admin_administrator_params
    opts.delete(:password) if opts[:password].blank?
    respond_to do |format|
      if @admin_administrator.update(opts)
        format.html { redirect_to admin_administrators_url, notice: 'Administrator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/administrators/1
  # DELETE /admin/administrators/1.json
  def destroy
    @admin_administrator.destroy
    respond_to do |format|
      format.html { redirect_to admin_administrators_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_administrator
      @admin_administrator = Administrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_administrator_params
      params.require(:administrator).permit(:email, :password, acl: [])
    end
end
