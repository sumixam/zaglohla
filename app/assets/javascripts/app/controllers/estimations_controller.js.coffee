class App.EstimationsController extends App.BaseController

  events:
    'change .js-car-brand' : 'getCarModel'
    'change .js-car-model' : 'getCarGeneration'
    'change .js-car-generation' : 'getCarEngine'

  constructor: ->
    super
    do @initSelect2

  getCarModel: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_models?car_brand_id=#{id}", (data) =>
        $('.js-car-model option').remove()
        $('.js-car-model').select2('data', null)
        $('.js-car-model').append($('<option>', {value:"0", text: "Модель"}))
        for m in data
          $('.js-car-model').append($('<option>', {value: m.id, text: m.name}))
        $('.js-car-model option:first').prop("selected", true)
        $(".js-car-model").trigger("change")

  getCarGeneration: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_generations?car_model_id=#{id}", (data) =>
        $('.js-car-generation option').remove()
        $('.js-car-generation').select2('data', null)
        $('.js-car-generation').append($('<option>', {value:"0", text: "Поколение"}))
        for m in data
          $('.js-car-generation').append($('<option>', {value: m.id, text: m.name}))
        $('.js-car-generation option:first').prop("selected", true)
        $(".js-car-generation").trigger("change")

  getCarEngine: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_engines?car_generation_id=#{id}", (data) =>
        $('.js-car-engine option').remove()
        $('.js-car-engine').select2('data', null)
        $('.js-car-engine').append($('<option>', {value:"0", text: "Двигатель"}))
        for m in data
          $('.js-car-engine').append($('<option>', {value: m.id, text: m.name}))
        $('.js-car-engine option:first').prop("selected", true)
        $(".js-car-engine").trigger("change")
