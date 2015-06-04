class App.CtoResponceFormController extends App.BaseController

  events:
    'change .js-car-brand' : 'getCarModel'
    'change .js-car-model' : 'getCarGeneration'
    'change .js-car-generation' : 'getCarEngine'
    'click .js-submit-request': 'submitForm'
    'click .js-add-row-resp': 'addRowResp'
    'click .js-rem-row-resp': 'remRowResp'

  constructor: ->
    super
    do @initSelect2
    do @reinitStar
    $(".js-date-input").pickmeup
      format: "d-m-Y"
      position: "top"

  submitForm: (e) ->
    @$("input, select, textarea").removeClass "sk-error"
    $(".js-star-cto").removeClass "sk-error-title"
    @$(".js-car-brand, .js-car-model, .js-car-generation, .js-car-engine").removeClass "sk-error"
    do e.preventDefault
    len = @$("input, select, textarea").map (i, e) ->
      ($(e).val().length > 0 && $(e).val() != 0) || $(e).hasClass("select2-offscreen") || $(e).hasClass("select2-input") || $(e).attr("type") == "hidden" || $(e).hasClass("js-skip-validation")
    tst = _.every len
    seltst = @$("select.js-car-select").map (i, e) ->
      selOpt = $(e).find("option:selected").attr("value")
      !(selOpt is undefined or parseInt(selOpt) == 0)
    tst2 = _.every(seltst) || $('.js-custom-car').val().length > 0
    if tst && tst2 && @validateEmail() && $(".star input").val() != ""
      $("#new_cto_response").submit()
    else
      if $(".star input").val() == ""
        $(".js-star-cto").addClass "sk-error-title"
      unless @validateEmail($(".js-email-validate").val())
        $(".js-email-validate").addClass "sk-error"
      @$("input, select, textarea").map (i, e) ->
        if $(e).val().length == 0
          $(e).addClass "sk-error"
      [".js-car-brand", ".js-car-model", ".js-car-generation"].each (e) =>
        selOpt = @$("select#{e} option:selected").attr("value")
        if (selOpt is undefined or parseInt(selOpt) == 0) and $('.js-custom-car').val().length == 0
          @$(e).addClass "sk-error"

  validateEmail: () ->
    return true unless $(".js-email-validate").length
    email = $(".js-email-validate").val()
    re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    re.test(email)

  addRowResp: (e) ->
    do e.preventDefault
    $( JST["app/views/ctos/new_fix_price"]() ).insertAfter( ".js-resp-row:last" )

  remRowResp: (e) ->
    do e.preventDefault
    $(e.target).parent().remove()

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
