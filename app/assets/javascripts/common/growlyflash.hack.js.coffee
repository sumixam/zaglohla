$(document).ready ->
  $(document).on 'click.alert.data-api', '[data-dismiss="alert"]', (e) ->
    e.stopPropagation()

  $(document).on 'touchstart click', ".bootstrap-growl", (e) ->
    e.stopPropagation()
    $('[data-dismiss="alert"]', @).click()
    off
