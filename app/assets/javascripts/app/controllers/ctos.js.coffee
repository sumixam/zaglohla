class App.Cto extends App.BaseController

  events:
    'click .js-send-mail': 'sendMail'
    'click .js-show-shared': 'showShared'
    'click .js-new-response': 'newResponse'
    'click .js-phone-hide': 'showPhone'
    'click .js-site-link': 'clickSiteLink'
    'click .js-vk-link': 'clickVkLink'
    'click .js-big-map': "showBigMap"
    'click .js-about-certificated': 'certNotification'

  constructor: ->
    super
    do @initTabs
    do @openGallery
    ymaps.ready =>
      do @initMap
    do @reinitStar
    mixpanel.track "CTO view page", { "cto name": @name(), "cto id": @ctoid() }

  name: ->
    @el.data("name")

  ctoid: ->
    @el.data("cto")

  showPhone: ->
    mixpanel.track "CTO show phone", { "cto name": @name(), "cto id": @ctoid() }

  clickSiteLink: ->
    mixpanel.track "CTO site visit", { "cto name": @name(), "cto id": @ctoid() }

  clickVkLink: ->
    mixpanel.track "CTO Vk visit", { "cto name": @name(), "cto id": @ctoid() }

  showForm: (url, callback) ->
    options =
      items:
        type: 'ajax'
        src: url
      callbacks:
        ajaxContentAdded: =>
          do callback
    $.magnificPopup.open options

  initTabs: ->
    $.ionTabs ".js-cto-tabs",
      onChange: =>
        do @reinitStar
    # $.ionTabs.setTab("cto-tabs", "tabs-1")

  showShared: (e) ->
    $(e.target).addClass("hidden")
    $(e.target).parent().find(".js-shared").removeClass("hidden")

  sendMail: ->
    mixpanel.track "CTO new request", { "cto name": @name(), "cto id": @ctoid() }
    @showForm("/invoices/new?cto_id=#{@ctoid()}",
      =>
        new App.SendInvoiceController(el: $(".js-cto-invoice-form")))


  newResponse: ->
    @showForm("/cto_responses/new?cto_id=#{$(".js-new-response").data("cto")}",
      =>
        new App.CtoResponceFormController(el: $(".js-cto-responce-form")))

  initMap: (addrs = []) ->
    if !@ymap
      if $(".js-cto-map").data("lat")
        coords = [$(".js-cto-map").data("lat"),$(".js-cto-map").data("lon")]
        zoom = 16
      else
        coords = [59.939,30.313]
        zoom = 9
      @ymap = new ymaps.Map 'ymap',
        center: coords
        zoom: zoom
      @ymap.controls.add('zoomControl', { left: 5, top: 5 })
      d = new ymaps.Placemark(coords, {
          balloonContentHeader: $(".js-cto-map").data("title"),
          balloonContentBody: $(".js-cto-map").data("addr")
      })
      @ymap.geoObjects.add(d)
    else
      @ymap.destroy()
      @ymap = null
      @initMap(addrs)

  openGallery: ->
    new App.CtoGalleryController

  showBigMap: ->
    $.magnificPopup.open
      items:
        type: "inline"
        src: JST["app/views/ctos/big_map"]()
      callbacks:
        open: =>
          if $(".js-cto-map").data("lat")
            coords = [$(".js-cto-map").data("lat"),$(".js-cto-map").data("lon")]
            zoom = 16
          else
            coords = [59.939,30.313]
            zoom = 9
          @bigymap = new ymaps.Map 'bigymap',
            center: coords
            zoom: zoom
          @bigymap.controls.add('zoomControl', { left: 5, top: 5 })

          d = new ymaps.Placemark(coords, {
            balloonContentHeader: $(".js-cto-map").data("title"),
            balloonContentBody: $(".js-cto-map").data("addr")
          })
          @bigymap.geoObjects.add(d)

  certNotification: (e) ->
    do e.preventDefault
    new App.TextPopupController(name:"cto_cert")
