class App.MainController extends App.BaseController

  events:
    "click .js-send-report" : "sendReport"
    "click .js-thanks" : "sendThank"

  sendReport: (e) ->
    new App.TextPopupController(name:"report", user_id: $(e.target).data("userid"))

  sendThank: (e) ->
    $.post("/profiles/#{$(e.target).data("userid")}/thank").then =>
      $(e.target).html("Вы сказали спасибо")
