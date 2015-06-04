class App.LoaderCtoList extends App.BaseController

  constructor: ->
    super
    do @initCtoSearch

  initCtoSearch: ->
    $(".js-admin-search-cto").select2
      placeholder: "Поиск"
      width: 'element'
      minimumInputLength: 3
      ajax:
        url: "/admin/loader_ctos/search",
        dataType: 'json',
        quietMillis: 100,
        data: (term, page) ->
            q: term
        results: (data, page) ->
            results: data.results
            more: false
    .on('change', (e) =>
      location.replace("/admin/loader_ctos/#{e.val}/edit")
    )
