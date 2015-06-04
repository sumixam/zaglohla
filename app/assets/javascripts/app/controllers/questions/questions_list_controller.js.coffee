class App.QuestionsListController extends App.BaseController

  events:
    "click .js-ask-question" : "askQuestionForm"
    "click .js-answer-show"  : "answerQuestionForm"
    "click .js-answer-list-show" : "showAnswersList"
    "click .js-registration": "showRegistrationForm"
    'change select.js-car-brand' : 'getCarModel'
    'change select.js-car-model' : 'getCarGeneration'
    'change select.js-car-generation' : 'getCarEngine'
    'click .js-question-search-button': 'search'

  constructor: ->
    super
    do @initMag
    do @initSelect2
    @pagination = $(".js-pagintation")

  initMag: ->
    $('.js-question-gallery').each ->
      $(this).magnificPopup
        delegate: 'a'
        type: 'image'
        gallery: {
          enabled:true
        }
    $('.js-answer-gallery').each ->
      $(this).magnificPopup
        delegate: 'a'
        type: 'image'
        gallery: {
          enabled:true
        }

  askQuestionForm: ->
    @showForm("/questions/new", => new App.QuestionsFormController(el: $(".js-question-form")))

  answerQuestionForm: (e)->
    qid = $(e.target).data("id")
    aname = $(e.target).data("aname") || ""
    @showForm("/answers/new?id=#{qid}", => new App.AnswerFormController(el: $(".js-answer-form"), aname: aname))

  showAnswersList: (e) ->
    id = $(e.target).data("id")
    $(".js-answers-#{id}").show()
    $(e.target).hide()

  showForm: (url, callback) ->
    options =
      items:
        type: 'ajax'
        src: url
      callbacks:
        ajaxContentAdded: =>
          do callback

    $.magnificPopup.open options

  showRegistrationForm: ->
    new App.RegistrationFormController

  search: (e) ->
    do e.preventDefault if e
    if ((parseInt($('select.js-car-brand').val()) || 0) == 0) && (parseInt($('select.js-job-type').val()) || 0) == 0
      if (parseInt($('select.js-car-brand').val()) || 0) == 0
        $(".js-car-brand").addClass "sk-error"
      if (parseInt($('select.js-job-type').val()) || 0) == 0
        $(".js-job-type").addClass "sk-error"
    else
      $(".js-car-model").removeClass "sk-error"
      $(".js-car-brand").removeClass "sk-error"
      $(".js-job-type").removeClass "sk-error"

      $.post('/questions/search', $(".js-question-form form").serialize()).done (data) =>
        $('.js-questions-show-container').html JST["app/views/questions/search"](
          result: data.result
          count: data.count
          page: data.page || 1
          current_user: data.current_user
          current_user_id: data.current_user_id
        )
        do @initMag
        if data.page == 1 || data.page is undefined
          if data.count > 20
            @pagination.pagination
              items: data.count
              itemsOnPage: 20
              currentPage: data.page || 1
              cssStyle: "compact-theme"
              prevText: "Предыдущая"
              nextText: "Следущая"
              onPageClick: (number, event) =>
                @nextPage(number, event)
          else
            @pagination.html ''

  setPage: (page = 1) ->
    $('.js-page-search').val(page)

  nextPage: (i, e) ->
    $("html, body").animate({scrollTop: 0}, "slow")
    do e.preventDefault
    @setPage(i)
    do @search

  resetPage: ->
    do @setPage

  getCarModel: (e) ->
    id = $(e.target).val()
    if parseInt(id+0) != 0
      $.getJSON "/car_models?car_brand_id=#{id}", (data) =>
        $('select.js-car-model option').remove()
        $('.js-car-model').select2('data', null)
        $('select.js-car-model').append($('<option>', {value:"0", text: "Модель"}))
        for m in data
          $('select.js-car-model').append($('<option>', {value: m.id, text: m.name}))
        $('.js-car-model option:first').prop("selected", true)
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
        $('.js-car-generation option:first').prop("selected", true)
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
        $('.js-car-engine option:first').prop("selected", true)
        $(".js-car-engine").trigger("change")
