class App.RepairRequestController extends App.BaseController

  events:
    'click .js-repair-request' : 'openForm'
    'change .js-car-brand' : 'getCarModel'
    'change .js-car-model' : 'getCarGeneration'
    'change .js-car-generation' : 'getCarEngine'
    'click .js-submit-request': 'submitForm'

  openForm: ->
    options =
      items:
        type: 'ajax'
        src: "/repair_requests/new"
      callbacks:
        ajaxContentAdded: =>
          do @initForms
          do @initSelect2

    $.magnificPopup.open options

  initForms: ->
    $('.js-car-brand').change (e) => @getCarModel(e)
    $('.js-car-model').change (e) => @getCarGeneration(e)
    $('.js-car-generation').change (e) => @getCarEngine(e)
    $('.js-submit-request').click (e) => @submitForm(e)

  submitForm: (e) ->
    $(".js-question-form input, .js-question-form select, .js-question-form textarea").removeClass "sk-error"
    $(".js-question-form .js-car-brand, .js-question-form .js-car-model, .js-question-form .js-car-generation, .js-question-form .js-car-engine").removeClass "sk-error"
    do e.preventDefault
    len = $(".js-question-form input, .js-question-form select, .js-question-form textarea").map (i, e) ->
      ($(e).val().length > 0 && $(e).val() != 0) || $(e).hasClass("select2-offscreen") || $(e).attr("type") == "hidden" || $(e).hasClass("select2-input") || $(e).attr("type") == "hidden" || $(e).hasClass("js-skip-validation")
    tst = _.every len
    seltst = $(".js-question-form select.js-car-select").map (i, e) ->
      selOpt = $(e).find("option:selected").attr("value")
      !(selOpt is undefined or parseInt(selOpt) == 0)
    tst2 = _.every(seltst) || $('.js-question-form  .js-custom-car').val().length > 0
    if tst && tst2
      $(".js-question-form form").submit()
    else
      $(".js-question-form input, .js-question-form select, .js-question-form textarea").map (i, e) ->
        if $(e).val().length == 0 && $(e).hasClass("js-skip-validation")
          $(e).addClass "sk-error"
      [".js-car-brand", ".js-car-model", ".js-car-generation"].each (e) =>
        selOpt = $(".js-question-form select#{e} option:selected").attr("value")
        if selOpt is undefined or parseInt(selOpt) == 0
          $(".js-question-form #{e}").addClass "sk-error"
      if !_.every(seltst) && $('.js-question-form  .js-custom-car').val().length == 0
        $('.js-question-form  .js-custom-car').addClass "sk-error"

  getCarModel: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_models?car_brand_id=#{id}", (data) =>
        $('.js-car-model option').remove()
        $('.js-car-model').select2('data', null)
        $('select.js-car-model').append($('<option>', {value:"0", text: "Модель"}))
        for m in data
          $('select.js-car-model').append($('<option>', {value: m.id, text: m.name}))
        $('select.js-car-model option:first').prop("selected", true)
        $(".js-car-model").trigger("change")

  getCarGeneration: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_generations?car_model_id=#{id}", (data) =>
        $('.js-car-generation option').remove()
        $('.js-car-generation').select2('data', null)
        $('select.js-car-generation').append($('<option>', {value:"0", text: "Поколение"}))
        for m in data
          $('select.js-car-generation').append($('<option>', {value: m.id, text: m.name}))
        $('select.js-car-generation option:first').prop("selected", true)
        $(".js-car-generation").trigger("change")

  getCarEngine: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_engines?car_generation_id=#{id}", (data) =>
        $('.js-car-engine option').remove()
        $('.js-car-engine').select2('data', null)
        $('select.js-car-engine').append($('<option>', {value:"0", text: "Двигатель"}))
        for m in data
          $('select.js-car-engine').append($('<option>', {value: m.id, text: m.name}))
        $('select.js-car-engine option:first').prop("selected", true)
        $(".js-car-engine").trigger("change")
