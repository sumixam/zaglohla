class App.CarsShowController extends App.BaseController

  events:
    'change .js-car-select-box' : 'changeCar'
    "click .js-add-car" : "addCarForm"
    "click .js-edit-car" : "editCarForm"
    "click .js-remove-car": "removeCar"

  addCarForm: ->
    @showForm("/cars/new", => new App.CarFormController(el: $(".js-car-form")))

  editCarForm: ->
    @showForm("/cars/#{$(".js-car-top").data("id")}/edit", => new App.CarFormController(el: $(".js-car-form")))

  constructor: ->
    super
    do @initSelect2
    do @initGallery

  initGallery: ->
    $('.js-gallery').magnificPopup({
      type: 'image',
      delegate: 'a',
      gallery:{
        enabled:true
      }
    })

  changeCar: (e) ->
    location.replace "/cars/#{$(e.target).val()}"

  showForm: (url, callback) ->
    options =
      items:
        type: 'ajax'
        src: url
      callbacks:
        ajaxContentAdded: =>
          do callback

    $.magnificPopup.open options

  removeCar: ->
    if confirm("Вы действительно хотите удалить этот автомобиль?")
      $.ajax(
        url: "/cars/#{$(".js-car-top").data("id")}",
        type: "DELETE",
        success: (res) ->
          window.location = "/cars"
      )
