class Admin::JobTypesController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @job_types = JobType.all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @job_type = JobType.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @job_type = JobType.new(admin_user_params)

    respond_to do |format|
      if @job_type.save
        format.html { redirect_to admin_job_types_path, notice: 'JobType was successfully created.' }
        format.json { render action: 'show', status: :created, location: @job_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @job_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @job_type.update(admin_user_params)
        format.html { redirect_to admin_job_types_path, notice: 'JobType was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @job_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @job_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_job_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @job_type = JobType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:job_type).permit(:name)
    end
end
