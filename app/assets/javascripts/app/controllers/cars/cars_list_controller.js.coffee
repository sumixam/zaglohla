class App.CarsListController extends App.BaseController

  events:
    "click .js-add-car" : "addCarForm"

  addCarForm: ->
    @showForm("/cars/new", => new App.CarFormController(el: $(".js-car-form")))

  showForm: (url, callback) ->
    options =
      items:
        type: 'ajax'
        src: url
      callbacks:
        ajaxContentAdded: =>
          do callback

    $.magnificPopup.open options
