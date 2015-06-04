class QuestionsController < ApplicationController
  def index
    session_checks
    if params[:tag].present?
      @questions = Question.tagged_with(params[:tag]).where(visible: true).where('user_id is not null').order('created_at DESC').page(params[:page]).per(10)
    else
      @questions = Question.where(visible: true).where('user_id is not null').order('created_at DESC').page(params[:page]).per(10)
    end
  end

  def create
    @question = Question.new(question_params)
    @question.save
    gflash notice: {
      time: 3000,
      value: "Ваш вопрос добавлен",
      title: "Спасибо",
      image: false,
      position: :bottom_right
    }
    if current_user.present?
      current_user.change_rating(5)
      auto_car_create(question_params)
    end
    redirect_to questions_path(user_exist: current_user.present?)
  end

  def show
    session_checks
    @question = Question.find(params[:id])
  end

  def search
    opts = params
    page = params[:page].to_i || 1

    res = Question.search do
      query do
        filtered do
          filter :terms, { car_brand_id: [opts[:car_brand_id]] } if opts[:car_brand_id].to_i > 0
          filter :terms, { car_engine_id: [opts[:car_engine_id]] } if opts[:car_engine_id].to_i > 0
          filter :terms, { car_model_id: [opts[:car_model_id]] } if opts[:car_model_id].to_i > 0
          filter :terms, { car_generation_id: [opts[:car_generation_id]] } if opts[:car_generation_id].to_i > 0
          filter :terms, { job_type_id: [opts[:job_type]] } if opts[:job_type].to_i > 0
          filter :terms, { visible: ["yes"] }
        end
      end
      sort { by :id, 'desc' }
      size 20
      from ((page - 1) * 20)
    end

    res_count = Tire.search(Question.index.name, search_type: 'count') {
      filter :terms, { car_brand_id: [opts[:car_brand_id]] } if opts[:car_brand_id].to_i > 0
      filter :terms, { car_engine_id: [opts[:car_engine_id]] } if opts[:car_engine_id].to_i > 0
      filter :terms, { car_model_id: [opts[:car_model_id]] } if opts[:car_model_id].to_i > 0
      filter :terms, { car_generation_id: [opts[:car_generation_id]] } if opts[:car_generation_id].to_i > 0
      filter :terms, { job_type_id: [opts[:job_type]] } if opts[:job_type].to_i > 0
      filter :terms, { visible: ["yes"] }
    }.results.total

    render json: {
      count: res_count,
      result: res.results.map{ |q|
        if q.load.user.present?
          q.load.to_hash.merge({
            user_avatar: q.load.user.avatar.url(:medium),
            user_name: q.load.user.name,
            user_type: q.load.user.user_type,
            created_date: q.load.created_at.strftime("%d-%m-%Y %H:%M"),
            car_full_name: q.load.car_full_name,
            photos: q.load.photos.map{|p| p.pic.url(:medium) },
            answers_count: q.load.answers.where('user_id is not null').count,
            tags: q.load.tags.map{ |t| t.name },
            alternative_name: q.load.alternative_name
          })
        else
          nil
        end
      }.compact,
      current_user: opts[:current_user],
      current_user_id: current_user.try(:id),
      page: page
    }
  end

  def new
    render layout:false
  end

  private

  def session_checks
    session[:question_user_hash] ||= SecureRandom.hex(10)
    if current_user.present?
      Question.where(user_hash: session[:question_user_hash], user_id: nil).update_all(user_id: current_user.id)
      Answer.where(user_hash: session[:question_user_hash], user_id: nil).update_all(user_id: current_user.id)
    end
  end

  def question_params
    params.require(:question).permit(:topic, :body, :user_id, :visible, :email_notification, :car_brand_id, :car_engine_id, :car_generation_id, :car_model_id, :job_type_id, :tag_list, :user_hash, :alternative_name, :year_of_production, photos_attributes: [:pic])
  end
end
