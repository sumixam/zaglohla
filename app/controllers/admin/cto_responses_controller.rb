class Admin::CtoResponsesController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @cto_reponses = CtoResponse.order("created_at desc").all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @cto_reponse = CtoResponse.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @cto_reponse = CtoResponse.new(admin_user_params)

    respond_to do |format|
      if @cto_reponse.save
        format.html { redirect_to admin_cto_reponses_path, notice: 'CtoResponse was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cto_reponse }
      else
        format.html { render action: 'new' }
        format.json { render json: @cto_reponse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @cto_reponse.update(admin_user_params)
        format.html { redirect_to admin_cto_reponses_path, notice: 'CtoResponse was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cto_reponse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @cto_reponse.destroy
    respond_to do |format|
      format.html { redirect_to admin_cto_responses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @cto_reponse = CtoResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:cto_reponse).permit(:name)
    end
end
