class App.ProfileController extends App.BaseController

  events:
    'click .js-about-points': 'showPointsHelper'

  showPointsHelper: ->
    new App.TextPopupController(name:"points_helper")
