class App.TextPopupController extends App.BaseController

  events:
    'click .js-devise-registration': 'showRegistrationForm'
    'click .js-devise-login': 'showLoginForm'

  className: "sk-modal-window o-modal-window st-center-relative response-module"

  showRegistrationForm: ->
    new App.RegistrationFormController

  showLoginForm: ->
    new App.LoginFormController

  constructor: ->
    super
    do @render

  initForm: ->
    $(".js-report-form").bind 'ajax:success', (xhr, data, status) =>
      do @closePopup

  render: ->
    @append JST["app/views/text_popups/#{@name}"](user_id: @user_id)
    do @openPopup
    do @initForm

