class Admin::UsersController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @users = User.order('id desc').all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    tts = params[:car_owner].present? ? :car_owner : :user
    @user = User.new(admin_user_params(tts))
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    params = admin_user_params(@user.type.underscore)
    params.delete(:password) if params[:password].empty?
    respond_to do |format|
      if @user.update(params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params(type)
      params.require(type.to_sym).permit(:name, :email, :phone, :password, :city_id, :type, :about_me, :cto_id)
    end
end
