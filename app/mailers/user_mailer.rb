class UserMailer < ActionMailer::Base
  default from: "\"Zaglohla\" <info@zaglohla.ru>"

  def invoice(invoice)
    @invoice = invoice
    mail to: "info@zaglohla.ru", subject: "Новая Заявка для #{@invoice.cto.name}!"
  end

  def welcome(user)
    mail to: user.email, subject: "Спасибо за регистрацию на Zaglohla.ru!"
  end

  def repair_request(repair_request)
    @repair_request = repair_request
    mail to: "info@zaglohla.ru", subject: "Новая Онлайн Заявка!"
  end

  def response_registration(email, passwd)
    @email = email
    @passwd = passwd
    mail to: email, subject: "Ваша заявка принята!"
  end

  def topic_update(email, question)
    @email = email
    @question = question
    mail to: email, subject: "Zaglohla.ru - Обвноление в теме: #{question.topic}"
  end
end
