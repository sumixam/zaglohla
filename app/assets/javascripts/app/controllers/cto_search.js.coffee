class App.CtoSearch extends App.BaseController

  events:
    'click .js-show-additional-form': 'showAdditionalForm'
    'click .js-search-button' : 'search'
    'click .js-left-select-brand': 'addBrandToSearch'
    'click .js-left-select-job-type': 'addJobTypeToSearch'
    'click .js-search-helper' : "openHelper"
    'click .js-certificate-helper' : "openCertificateHelper"
    'click .js-about-rating' : "openRatingHelper"
    'click .js-car-brand-show-more' : "moreCarBrands"
    'click .js-job-type-show-more' : "moreJobTypes"
    'click .js-next-page' : "nextPage"
    'click .js-big-map': "showBigMap"
    'change .js-search-form-element' : 'resetPage'
    'change select.js-select2-brand' : 'showHideSpec'
    'change select.js-select2-category' : 'resetBrand'
    'click .js-quick-car-brand' : 'clickQUickCarBrand'
    'click .js-quick-job-type' : 'clickQUickJobType'
    'change .js-search-form input': 'checkDisable'
    'change .js-search-form select': 'checkDisable'

  elements:
    '.js-accordion': 'accordionHolder'
    '.js-pagintation': 'pagination'

  constructor: ->
    super
    _.delay (=> $(".js-search-cto-form-module").animate opacity: 1), 1000
    do @initSelect2
    do @initHelpers
    do @showHideSpec
    do @initDirectSearch
    do @resetBrand
    if $("select.js-select2-job-type").val()
      do @showAdditionalForm
    ymaps.ready =>
      do @checkDisable
      if @ctos.length
        addrs = []
        for r in @ctos
          addrs.push [[r.lat, r.lon], r.id, r.name]
        @initMap(addrs)
        @addrs = addrs
      else
        do @initMap
      if $('.js-force-search').length > 0
        do @search

  initDirectSearch: ->
    $(".js-direct-search-cto").select2
      placeholder: "Быстрый поиск СТО по названию"
      width: 'element'
      minimumInputLength: 3
      maximumSelectionSize: 1
      multiple: true
      ajax:
        url: "/ctos/direct_search",
        dataType: 'json',
        quietMillis: 100,
        data: (term, page) ->
            q: term
        results: (data, page) ->
            results: data.results
            more: false
    .on('change', (e) =>
      mixpanel.track "Search quick search", { "text": e.added.text }
      location.replace("/ctos/#{e.val}")
    )

  showBigMap: ->
    mixpanel.track "Search view big map"
    $.magnificPopup.open
      items:
        type: "inline"
        src: JST["app/views/ctos/big_map"]()
      callbacks:
        open: =>
          xs = []
          ys = []
          for a in @addrs
            if a[0][0] != NaN && a[0][1] != NaN && a[0][0] != "" && a[0][1] != ""
              xs.push parseFloat(a[0][0])
              ys.push parseFloat(a[0][1])
          if xs.length
            if xs.length == 1
              center = [xs[0],ys[0]]
              zoom = 16
            else
              bounds = ymaps.util.bounds.getCenterAndZoom [[xs.min(), ys.min()], [xs.max(), ys.max()]], [380, 380]
              center = bounds.center
              zoom = if bounds.zoom > 16 then 16 else bounds.zoom
          else
            center = [59.939,30.313]
            zoom = 9
          if zoom is NaN
            center = [59.939,30.313]
            zoom = 9
          @bigymap = new ymaps.Map 'bigymap',
            center: center
            zoom: zoom
          @bigymap.controls.add('zoomControl', { left: 5, top: 5 })
          for a in @addrs
            d = new ymaps.Placemark(a[0], {
                balloonContentHeader: a[2],
                balloonContentBody: "<a href='/ctos/#{a[1]}'>Перейти на страницу СТО</a>"
            })
            @bigymap.geoObjects.add(d)

  resetBrand: ->
    id = $('select.js-select2-category').val()
    if parseInt(id+0) != 0
      $.getJSON "/car_brands?category_auto=#{id}", (data) =>
        $('select.js-select2-brand option').remove()
        $('select.js-select2-brand').select2('data', null)
        $('select.js-select2-brand').append($('<option>', {value:"", text: "Выберите марку"}))
        for m in data
          $('select.js-select2-brand').append($('<option>', {value: m.id, text: m.name}))
        $('select.js-select2-brand option:first').prop("selected", true)
        $("select.js-select2-brand").trigger("change")

  checkDisable: ->
    if $('.js-force-search').length == 0 && !$("select.js-select2-brand").val() && !$("select.js-select2-location").val() && !$("select.js-select2-job-type").val() && $("select.js-select2-category").val() == "1"
      $(".js-search-button").addClass("sk-disbaled")
    else
      $(".js-search-button").removeClass("sk-disbaled")

  moreCarBrands: (e) ->
    $(e.target).hide()
    $(".js-car-brand-show-more-list").show()

  moreJobTypes: (e) ->
    $(e.target).hide()
    $(".js-job-type-show-more-list").show()

  showAdditionalForm: ->
    if $('.js-show-additional-form').data("open") == 0
      $('.js-show-additional-form').removeClass('sk-pseudo-bottom-arrow').addClass('sk-pseudo-top-arrow')
      $('.js-additional-form').slideDown()
      $('.js-show-additional-form').data("open", 1)
    else
      $('.js-additional-form').slideUp()
      $('.js-show-additional-form').removeClass('sk-pseudo-top-arrow').addClass('sk-pseudo-bottom-arrow')
      $('.js-show-additional-form').data("open", 0)

  search: ->
    if $('.js-force-search').length == 0 && !$("select.js-select2-brand").val() && !$("select.js-select2-location").val() && !$("select.js-select2-job-type").val() && $("select.js-select2-category").val() == "1"
      $(".js-select2-brand").addClass "sk-error"
      $(".js-select2-location").addClass "sk-error"
      $(".js-select2-job-type").addClass "sk-error"
    else
      $(".js-select2-brand").removeClass "sk-error"
      $(".js-select2-location").removeClass "sk-error"
      $(".js-select2-job-type").removeClass "sk-error"
      $('.js-search-container').html JST["app/views/ctos/loader"]()
      mixpanel.track "Search from Form",
        brand: if $("select.js-select2-brand").val() == "" then null else $("select.js-select2-brand option:selected").html()
        location: if $("select.js-select2-location").val() then $("select.js-select2-location option:selected").map((i, el) -> $(el).html().trim()).toArray() else null
        job: if $("select.js-select2-job-type").val() then $("select.js-select2-job-type option:selected").map((i, el) -> $(el).html().trim()).toArray() else null
      $.post('/ctos/search', $(".js-search-form").serialize()).done (data) =>
        if data.result.length > 0
          addrs = []
          for r in data.result
            addrs.push [[r.lat, r.lon], r.id, r.name]
          if addrs.length > 0
            @initMap(addrs)
            @addrs = addrs
        $('.js-search-container').html JST["app/views/ctos/search"](
          result: data.result
          count: data.count
          page: data.page || 1
          search_brand: if $("select.js-car-brand-select").val() == "" then null else $("select.js-car-brand-select option:selected").html()
          job_type: if $("select.js-select2-job-type option:selected").length > 0 then $("select.js-select2-job-type option:selected").map((i, el) -> $(el).html().trim()).toArray().join(", ") else null
          metro: $('select.js-select2-location option:selected').map( (i, e) -> $(e).html() if $(e).attr("value").has("m-")).toArray()
        )
        do @reinitStar
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

  initMap: (addrs = []) ->
    if !@ymap
      xs = []
      ys = []
      for a in addrs
        if a[0][0] != NaN && a[0][1] != NaN && a[0][0] != "" && a[0][1] != ""
          xs.push parseFloat(a[0][0])
          ys.push parseFloat(a[0][1])
      if xs.length
        if xs.length == 1
          center = [xs[0],ys[0]]
          zoom = 16
        else
          bounds = ymaps.util.bounds.getCenterAndZoom [[xs.min(), ys.min()], [xs.max(), ys.max()]], [380, 380]
          center = bounds.center
          zoom = if bounds.zoom > 16 then 16 else bounds.zoom
      else
        center = [59.939,30.313]
        zoom = 9
      if zoom is NaN
        center = [59.939,30.313]
        zoom = 9
      @ymap = new ymaps.Map 'ymap',
        center: center
        zoom: zoom
      @ymap.controls.add('zoomControl', { left: 5, top: 5 })
      for a in addrs
        d = new ymaps.Placemark(a[0], {
            balloonContentHeader: a[2],
            balloonContentBody: "<a href='/ctos/#{a[1]}'>Перейти на страницу СТО</a>"
        })
        @ymap.geoObjects.add(d)
    else
      @ymap.destroy()
      @ymap = null
      @initMap(addrs)

  initHelpers: =>
    $(".js-location-list").click =>
      @mag = $.magnificPopup.open
        items:
          type: "inline"
          src: $(".js-metro-district").html()
        callbacks:
          open: =>
            do @initAccordion
      $(".js-location-select").click (e) =>
        vals = $("select.js-select2-location").val() || []
        vals.push $(e.target).data("id")
        $("select.js-select2-location").val(vals).trigger("change")
        $.magnificPopup.close()
    $(".js-job-type-list").click ->
      @mag = $.magnificPopup.open
        items:
          type: "inline"
          src: $(".js-job-types").html()
        callbacks:
          open: =>
            $('.js-accordion').accordion(heightStyle: "content")
      $(".js-job-type-select").click (e) =>
        vals = $("select.js-select2-job-type").val() || []
        vals.push $(e.target).data("id")
        $("select.js-select2-job-type").val(vals).trigger("change")
        $.magnificPopup.close()

  setPage: (page = 1) ->
    $('.js-page-search').val(page)

  nextPage: (i, e) ->
    $("html, body").animate({scrollTop: 0}, "slow")
    do e.preventDefault
    @setPage(i)
    do @search

  resetPage: ->
    do @setPage

  showHideSpec: ->
    if $("select.js-select2-brand").val()
      $(".js-cto-question-container").show()
    else
      $(".js-cto-question-container").hide()

  addBrandToSearch: (e) ->
    $("select.js-select2-brand").val($(e.target).data("id")).trigger("change")

  addJobTypeToSearch: (e) ->
    vals = $("select.js-select2-job-type").val() || []
    vals.push $(e.target).data("id")
    $("select.js-select2-job-type").val(vals).trigger("change")

  initAccordion: ->
    $('.js-accordion').accordion(heightStyle: "content")

  openHelper: ->
    new App.TextPopupController(name:"search_helper")

  openCertificateHelper: ->
    new App.TextPopupController(name:"certificate_helper")

  openRatingHelper: (e) ->
    do e.preventDefault
    new App.TextPopupController(name:"rating_helper")

  clickQUickCarBrand: (e) ->
    mixpanel.track "Search choose quick brand", { "brand name": $(e.target).html() }

  clickQUickJobType: (e) ->
    mixpanel.track "Search choose quick job", { "job name": $(e.target).html() }
