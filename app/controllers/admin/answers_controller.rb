class Admin::AnswersController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @answers = Answer.order('created_at DESC').all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @answer = Answer.new(question_id: params[:question_id])
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @answer = Answer.new(admin_user_params)

    if params[:new_user] == "1"
      user = User.where(email: admin_user_params[:email]).first || User.create(admin_user_user_params.merge(password: SecureRandom.hex(6)))
      @answer.user_id = user.id
    end

    respond_to do |format|
      if @answer.save
        format.html { redirect_to admin_questions_path, notice: 'Answer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @answer.update(admin_user_params)
        if params[:new_user] == "1"
          user = User.where(email: admin_user_params[:email]).first || User.create(admin_user_user_params.merge(password: SecureRandom.hex(6)))
          @answer.user_id = user.id
          @answer.save
        end
        format.html { redirect_to admin_questions_path, notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to admin_questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:answer).permit(:body, :user_id, :created_at, :question_id)
    end

    def admin_user_user_params
      params.require(:user).permit(:email, :name)
    end
end
