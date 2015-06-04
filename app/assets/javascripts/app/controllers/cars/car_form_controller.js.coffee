class App.CarFormController extends App.BaseController

  events:
    'change .js-car-brand' : 'getCarModel'
    'change .js-car-model' : 'getCarGeneration'
    'change .js-car-generation' : 'getCarEngine'
    'click .js-add-photos' : 'addPhoto'
    'click .js-plus-photo' : 'plusPhoto'
    'click .js-submit-car' : 'submitForm'

  constructor: ->
    super
    do @initSelect2

  getCarModel: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_models?car_brand_id=#{id}", (data) =>
        $('select.js-car-model option').remove()
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
        $('select.js-car-generation option').remove()
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
        $('select.js-car-engine option').remove()
        $('.js-car-engine').select2('data', null)
        $('select.js-car-engine').append($('<option>', {value:"0", text: "Двигатель"}))
        for m in data
          $('select.js-car-engine').append($('<option>', {value: m.id, text: m.name}))
        $('select.js-car-engine option:first').prop("selected", true)
        $(".js-car-engine").trigger("change")

  addPhoto: ->
    $('.js-add-photos').hide()
    $('.js-photo-input').show()
    $(".js-plus-photo:last").trigger("click")

  plusPhoto: (e) ->
    e.preventDefault()
    $('.js-plus-photo').parent().prepend '<div><input class="js-car-photo-input st-unitLeft d2-push-top" name="car[photos_attributes][][pic]" type="file" value="1" data-buttonText="Заменить файл"><div class="st-unitLeft d2-push-top d2-push-left rm-photo js-rm-photo">x</div><div class="clear"/></div>'
    $(".js-car-photo-input:last").trigger("click")

  rmPhoto: (e) ->
    e.preventDefault()
    $(e.target).parent().remove()

  submitForm: (e) ->
    if @formShouldBeSubmited
      return true
    @$("input, select, textarea").removeClass "sk-error"
    @$(".js-car-brand, .js-car-model, .js-car-generation, .js-car-engine").removeClass "sk-error"
    do e.preventDefault
    len = @$("input, select, textarea").map (i, e) ->
      ($(e).val().length > 0 && $(e).val() != 0) || $(e).hasClass("select2-offscreen") || $(e).hasClass("select2-input") || $(e).attr("type") == "hidden" || $(e).hasClass("js-skip-validation")
    tst = _.every len
    seltst = @$("select.js-car-select").map (i, e) ->
      selOpt = $(e).find("option:selected").attr("value")
      !(selOpt is undefined or parseInt(selOpt) == 0)
    tst2 = _.every(seltst) || $('.js-alternative-name').val().length > 0
    console.log tst, tst2
    if tst && tst2
      @formShouldBeSubmited = true
      $("#new_car").submit()
    else
      @$("input, select, textarea").map (i, e) ->
        if $(e).val().length == 0 && !$(e).hasClass("js-skip-validation")
          $(e).addClass "sk-error"
      unless tst2
        [".js-car-brand", ".js-car-model"].each (e) =>
          selOpt = @$("select#{e} option:selected").attr("value")
          if (selOpt is undefined or parseInt(selOpt) == 0) and $('.js-alternative-name').val().length == 0
            @$(e).addClass "sk-error"
        if $('.js-alternative-name').val().length == 0
          $('.js-alternative-name').addClass "sk-error"
