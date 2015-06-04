class App.AdminRepairList extends Spine.Controller

  events:
    'change .js-car-brand' : 'getCarModel'
    'change .js-car-model' : 'getCarGeneration'
    'change .js-car-generation' : 'getCarEngine'
    'change .js-repair-work-sector' : 'getWorkType'
    'change .js-repair-work-type' : 'getWorkJob'
    'click  .js-calc' : 'calculate'

  constructor: ->
    super
    do @initSelect2

  initSelect2: ->
    @$('.js-select2').select2()

  getCarModel: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_models?car_brand_id=#{id}", (data) =>
        do @cleanCarModel
        for m in data
          $('.js-car-model').append($('<option>', {value: m.id, text: m.name}))
        $('.js-car-model option:first').prop("selected", true)
        $(".js-car-model").trigger("change")

  getCarGeneration: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_generations?car_model_id=#{id}", (data) =>
        do @cleanCarGeneration
        for m in data
          $('.js-car-generation').append($('<option>', {value: m.id, text: m.name}))
        $('.js-car-generation option:first').prop("selected", true)
        $(".js-car-generation").trigger("change")

  getCarEngine: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_engines?car_generation_id=#{id}", (data) =>
        do @cleanCarEngine
        for m in data
          $('.js-car-engine').append($('<option>', {value: m.id, text: m.name}))
        $('.js-car-engine option:first').prop("selected", true)
        $(".js-car-engine").trigger("change")

  getWorkType: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/repair_work_types?repair_work_sector_id=#{id}", (data) =>
        do @cleanWorkType
        for m in data
          $('.js-repair-work-type').append($('<option>', {value: m.id, text: m.name}))
        $('.js-repair-work-type option:first').prop("selected", true)
        $(".js-repair-work-type").trigger("change")

  getWorkJob: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/repair_work_jobs?repair_work_type_id=#{id}", (data) =>
        do @cleanWorkJob
        for m in data
          $('.js-repair-work-job').append($('<option>', {value: m.id, text: m.name}))
        $('.js-repair-work-job option:first').prop("selected", true)
        $(".js-repair-work-job").trigger("change")

  cleanWorkType: ->
    $('.js-repair-work-type option').remove()
    $('.js-repair-work-type').select2('data', null)
    $('.js-repair-work-type').append($('<option>', {value:"0", text: "Тип работ"}))

  cleanWorkJob: ->
    $('.js-repair-work-job option').remove()
    $('.js-repair-work-job').select2('data', null)
    $('.js-repair-work-job').append($('<option>', {value:"0", text: "Работа"}))

  cleanCarModel: ->
    $('.js-car-model option').remove()
    $('.js-car-model').select2('data', null)
    $('.js-car-model').append($('<option>', {value:"0", text: "Модель"}))

  cleanCarGeneration: ->
    $('.js-car-generation option').remove()
    $('.js-car-generation').select2('data', null)
    $('.js-car-generation').append($('<option>', {value:"0", text: "Поколение"}))

  cleanCarEngine: ->
    $('.js-car-engine option').remove()
    $('.js-car-engine').select2('data', null)
    $('.js-car-engine').append($('<option>', {value:"0", text: "Двигатель"}))

  calculate: (e) ->
    e.preventDefault()
    ceid = $("select.js-car-engine").val()
    wjid = $("select.js-repair-work-job").val()
    $.post "/admin/repaires/calcs.json", {car_engine_id: ceid, repair_work_job_id: wjid}, (data) =>
      $(".js-result").html data.text
