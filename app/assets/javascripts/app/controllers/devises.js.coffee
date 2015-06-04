class App.Devise extends App.BaseController
  events:
    'click .js-devise-registration': 'showRegistrationForm'
    'click .js-devise-login': 'showLoginForm'

  constructor: ->
    super

  showLoginForm: ->
    new App.LoginFormController

  showRegistrationForm: ->
    new App.RegistrationFormController

