class App.LoginFormController extends App.BaseController

  elements:
    ".js-devise-login-form": "loginForm"

  constructor: ->
    super
    do @render

  render: ->
    @append JST["app/views/devise/login"]()
    do @openPopup
    do @initFormBehavior

  initFormBehavior: ->
    @loginForm.bind 'ajax:success', (xhr, data, status) ->
      window.location = window.location.href.split("?")[0]
    @loginForm.bind 'ajax:error', (xhr, data, status) ->
      $.gritter.add({title: "Ошибка", text: 'Неправильная пара email / пароль'})
