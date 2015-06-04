class App.AnswerFormController extends App.BaseController

  events:
    'click .js-add-photos' : 'addPhoto'
    'click .js-plus-photo' : 'plusPhoto'
    'click .js-rm-photo': 'rmPhoto'

  constructor: ->
    super
    if @aname
      $("#answer_body").val @aname

  addPhoto: ->
    $('.js-add-photos').hide()
    $('.js-photo-input').show()
    $(".js-plus-photo:last").trigger("click")

  plusPhoto: (e) ->
    e.preventDefault()
    $('.js-plus-photo').parent().prepend '<div><input class="js-question-photo-input st-unitLeft d2-push-top" name="answer[photos_attributes][][pic]" type="file" value="1" data-buttonText="Заменить файл"><div class="st-unitLeft d2-push-top d2-push-left rm-photo js-rm-photo">x</div><div class="clear"/></div>'
    $(".js-answer-photo-input:last").trigger("click")

  rmPhoto: (e) ->
    e.preventDefault()
    $(e.target).parent().remove()
