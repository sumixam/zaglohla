class App.RegistrationFormController extends App.BaseController

  elements:
    ".js-devise-registration-form": "registrationForm"

  constructor: ->
    super
    do @render

  render: ->
    @append JST["app/views/devise/registration"](text: @text)
    do @openPopup
    do @initFormBehavior

  initFormBehavior: ->
    @registrationForm.bind 'ajax:success', (xhr, data, status) ->
      window.location = window.location.href.split("?")[0]
    @registrationForm.bind 'ajax:error', (xhr, status, error) ->
      err = []
      console.log status, status.responseJSON
      if !_.isEmpty(status.responseJSON.errors["password"])
        err.push "Пароль #{status.responseJSON.errors["password"].join(", ")}"
      if !_.isEmpty(status.responseJSON.errors["password_confirmation"])
        err.push "Подтверждение пароля #{status.responseJSON.errors["password_confirmation"].join(", ")}"
      if !_.isEmpty(status.responseJSON.errors["email"])
        err.push "Email #{status.responseJSON.errors["email"].join(", ")}"
      if err.length == 0
        err.push 'Неправильная пара email / пароль'
      $.gritter.add({title: "Ошибка", text: err.join(". ")})
