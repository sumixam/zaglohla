class App.UserEdit extends App.BaseController

  events:
    'change .js-user-type': 'changeUserType'

  constructor: ->
    super
    do @initSelect2
    do @changeUserType

  userId: ->
    @el.data('id')

  initSelect2: ->
    super
    format = (state) ->
      originalOption = state.element
      state.text + $(originalOption).data("address")
    $('.js-select2-cto').select2
      formatResult: format,
      formatSelection: format,
      escapeMarkup: (m) -> m

  changeUserType: ->
    console.log $("select.js-user-type").val()
    if $("select.js-user-type").val() == "Mechanic"
      $(".js-mechanic").show()
    else
      $(".js-mechanic").hide()
