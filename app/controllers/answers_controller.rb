class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)
    @answer.save
    gflash notice: {
      time: 3000,
      value: "Ваш ответ добавлен",
      title: "Спасибо",
      image: false,
      position: :bottom_right
    }
    if current_user.present?
      if Question.find(params[:answer][:question_id]).answers.count > 1
        current_user.change_rating(10)
      else
        current_user.change_rating(15)
      end
    end
    notify_topic(params[:answer][:question_id], @answer.id)
    redirect_to question_path(Question.find(params[:answer][:question_id]), user_exist: current_user.present?)
  end

  def show
  end

  def new
    @question = Question.find(params[:id])
    render layout:false
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :user_id, :question_id, :email_notification, :user_hash, photos_attributes: [:pic])
  end

  def notify_topic(question_id, answer_id)
    emails = []
    question = Question.find(question_id)
    emails << question.user.email if question.user && question.email_notification && current_user.try(:id) != question.user.id
    question.answers.where('user_id is not null').each do |a|
      if a.user && a.email_notification && a.id != answer_id && current_user.try(:id) != a.user.id
        emails << a.user.email
      end
    end
    emails.uniq.each do |e|
      UserMailer.topic_update(e, question).deliver
    end
  end
end
