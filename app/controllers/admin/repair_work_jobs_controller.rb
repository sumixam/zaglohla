class Admin::RepairWorkJobsController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @repair_work_type = RepairWorkType.find(params[:type_id])
    @repair_work_sector = @repair_work_type.repair_work_sector
    @repair_work_jobs = RepairWorkType.find(params[:type_id]).repair_work_jobs
    render layout: false
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @repair_work_job = RepairWorkJob.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @repair_work_job = RepairWorkJob.new(admin_user_params)

    respond_to do |format|
      if @repair_work_job.save
        format.html { redirect_to admin_repair_work_sectors_path, notice: 'Service was successfully created.' }
        format.json { render action: 'show', status: :created, location: @repair_work_job }
      else
        format.html { render action: 'new' }
        format.json { render json: @repair_work_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @repair_work_job.update(admin_user_params)
        format.html { redirect_to admin_repair_work_sectors_path, notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @repair_work_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @repair_work_job.destroy
    respond_to do |format|
      format.html { redirect_to admin_repair_work_sectors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @repair_work_job = RepairWorkJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:repair_work_job).permit(:name)
    end
end
