class App.LoaderCto extends App.BaseController

  elements:
    '.js-brand-selection' : 'brandSelection'

  events:
    'change .js-city' : 'updateCityDepend'
    'click .js-add-guarantee' : 'addGuarantee'
    'click .js-add-pricelist' : 'addPricelist'
    'click .js-add-cto-share' : 'addCtoShare'
    'click .js-add-equipment' : 'addEquipment'
    'click .js-add-work-hour button' : 'addWorkHour'
    'click .js-work-hours-rm button' : 'removeWorkHour'
    'click .js-guarantee-rm button' : 'removeGuarantee'
    'click .js-pricelist-rm button' : 'removePricelist'
    'click .js-cto-share-rm button' : 'removeCtoShare'
    'click .js-equipment-rm button' : 'removeEquipment'
    'click .js-select-all-sub-job-types' : 'selectAllSubJobTypes'
    'click .js-place-on-maps' : 'placeBaloon'
    'change .js-job-type-checkbox' : 'reinitSubJobTypes'
    'change .js-category-auto' : 'reinitMarkSelection'
    'change .js-select-all' : 'selectAllBrands'
    'change .js-select-local' : 'selectLocalBrands'
    'change .js-select-foreight' : 'selectForeightBrands'
    'change .js-disbrands-select2' : 'selectDisbrands'

  constructor: ->
    super
    do @initPhotoUploader
    do @initMasks
    do @reinitSubJobTypes
    do @reinitMarkSelection
    do @initCerts
    ymaps.ready =>
      do @initMap
    $('.js-brands-select2').select2()
    $('.js-disbrands-select2').select2()
    do @initDatepick
    # $(".js-pricelist-cto").

  initDatepick: ->
    $(".js-date-input").pickmeup
      format: "d-m-Y"
      position: "top"

  initCerts: ->
    $( ".js-manual-certs" ).select2
      tags: $(".js-manual-certs").data("certs").split(",")

  reinitSubJobTypes: ->
    $('.js-sub-job-types').hide()
    $('.js-job-type-checkbox:checked').each (i, el) ->
      $(".js-sub-job-types-#{$(el).data("id")}").show()

  reinitMarkSelection: ->
    $('.js-brand-selection').hide()
    $('.js-category-auto:checked').each (i, el) ->
      $(".js-brand-selection-#{$(el).val()}").show()

  updateCityDepend: ->
    # do @updateDistrict
    # do @updateMetro

  updateDistrict: ->
    $.getJSON '/districts',
      { city_id: $('.js-city').val()},
      (data) ->
        if data.length
          $('.js-districts .js-controls').html JST['app/views/admin/loader_cto/districts'](districts: data)
          do $('.js-districts').show
        else
          $('.js-districts .js-controls').html ''
          do $('.js-districts').hide

  updateMetro: ->
    $.getJSON '/metro_stations',
      { city_id: $('.js-city').val()},
      (data) ->
        if data.length
          $('.js-metro .js-controls').html JST['app/views/admin/loader_cto/metros'](metros: data)
          do $('.js-metro').show
        else
          $('.js-metro .js-controls').html ''
          do $('.js-metro').hide

  initPhotoUploader: ->
    $(document).ready =>
      $('.js-photo-cto-upload').click (event) ->
        event.preventDefault()
      do @refreshPhotoList

    $('.js-photo-cto-upload').uploadify
      'swf' : "#{location.origin}/uploadify.swf"
      'uploader' : '/admin/photos'
      'multi' : true
      'formData' : {
        'imageable_id' : $('.js-cto-id').val()
        'imageable_type' : 'Cto'
      }
      'onUploadComplete': =>
        do @refreshPhotoList

    $('.js-photo-cto-upload-submit').click (event) ->
      event.preventDefault()
      $('.js-photo-cto-upload').uploadifyUpload()

  refreshPhotoList: ->
    $.getJSON('/admin/photos', {id: $('.js-cto-id').val()}, (data) =>
      $('.js-current-photos').html JST['app/views/admin/loader_cto/photos'](photos: data)
      $('.js-current-photos').delegate('.js-remove-photo', 'click', (e) ->
        $.post("/admin/photos/#{$(e.target).data("id")}", _method: "delete")
        $(e.target).parent().remove()
      )

      $('.js-current-photos').delegate('.js-main-photo', 'click', (e) =>
        id = $(e.target).val()
        $.post("/admin/photos/#{id}",
          _method: "patch"
          "photo[main]": true
        , =>
          do @refreshPhotoList
        )
      )
    )

  removePhoto: (e) ->
    console.log e

  addGuarantee: (e) ->
    do e.preventDefault
    $('.js-guarantee .js-controls').append JST['app/views/admin/loader_cto/guarantee']

  addPricelist: (e) ->
    do e.preventDefault
    $('.js-pricelists .js-controls').append JST['app/views/admin/loader_cto/pricelist']
    do @initDatepick

  addCtoShare: (e) ->
    do e.preventDefault
    $('.js-cto-shares .js-controls').append JST['app/views/admin/loader_cto/cto_share']
    do @initDatepick

  addEquipment: (e) ->
    do e.preventDefault
    $('.js-equipment .js-controls').append JST['app/views/admin/loader_cto/equipment']

  addWorkHour: (e) ->
    do e.preventDefault
    $('.js-work-hours .js-controls').append JST['app/views/admin/loader_cto/work_hour']

  removeWorkHour: (e) ->
    do e.preventDefault
    $(e.target).parents('.js-work-hour-row').remove()

  removeGuarantee: (e) ->
    do e.preventDefault
    $(e.target).parents('.js-guarantee-row').remove()

  removePricelist: (e) ->
    do e.preventDefault
    $(e.target).parents('.js-pricelist-row').remove()

  removeCtoShare: (e) ->
    do e.preventDefault
    $(e.target).parents('.js-cto-share-row').remove()

  removeEquipment: (e) ->
    do e.preventDefault
    $(e.target).parents('.js-equipment-row').remove()

  initMasks: ->
    $(".js-phone").inputmask("mask", {"mask": "(999) 999-9999"})
    $(".js-site").inputmask("url")

  selectAllBrands: (e) ->
    tcs = $(e.target).data("id")
    $(".js-brand-selection-#{tcs} option.js-brand-all").attr("selected", "selected")
    $(".js-brand-select-2-#{tcs}").trigger("change")
    $(e.target).removeAttr("checked")
    false

  selectLocalBrands: (e) ->
    tcs = $(e.target).data("id")
    $(".js-brand-selection-#{tcs} option.js-local-brand").attr("selected", "selected")
    $(".js-brand-selection-#{tcs} option.js-foreight-brand").removeAttr("selected")
    $(".js-brand-select-2-#{tcs}").trigger("change")
    $(e.target).removeAttr("checked")
    false

  selectForeightBrands: (e) ->
    tcs = $(e.target).data("id")
    $(".js-brand-selection-#{tcs} option.js-local-brand").removeAttr("selected")
    $(".js-brand-selection-#{tcs} option.js-foreight-brand").attr("selected", "selected")
    $(".js-brand-select-2-#{tcs}").trigger("change")
    $(e.target).removeAttr("checked")

  selectAllSubJobTypes: (e) ->
    sbid = $(e.target).data("id")
    $(".js-sub-job-types-#{sbid} input").prop("checked", true)

  selectDisbrands: (e) ->
    sbid = $(e.target).data("ctoid")
    $(e.target).val().each (i) ->
      $(".js-brand-selection-#{sbid} option").each (s, e) ->
        if $(e).attr("value") == i
          $(e).removeAttr("selected")
      $(".js-brand-select-2-#{sbid}").trigger("change")

  initMap: () ->
    if !@ymap
      @ymap = new ymaps.Map 'ymap',
        center: [59.939,30.313]
        zoom: 9
      @yplacemark = null

      if $('.js-lat').val()
        @addPlacemark([$('.js-lat').val(), $('.js-lon').val()])

      @ymap.controls
        .add('zoomControl', { left: 5, top: 5 })
        .add('typeSelector')

      @ymap.events.add "click", (e) =>
        coords = e.get("coords")
        $('.js-lat').val(coords[0])
        $('.js-lon').val(coords[1])
        @addPlacemark(coords)

  createPlacemark: (coords) =>
    new ymaps.Placemark(coords,
      iconContent: "поиск..."
    ,
      preset: "twirl#violetStretchyIcon"
      draggable: true
    )

  getAddress: (coords) =>
    @yplacemark.properties.set "iconContent", "поиск..."
    ymaps.geocode(coords).then (res) =>
      firstGeoObject = res.geoObjects.get(0)
      @yplacemark.properties.set
        iconContent: firstGeoObject.properties.get("name")
        balloonContent: firstGeoObject.properties.get("text")

  addPlacemark: (coords) =>
    if @yplacemark
      @yplacemark.geometry.setCoordinates coords
    else
      @yplacemark = @createPlacemark(coords)
      @ymap.geoObjects.add @yplacemark
      @yplacemark.events.add "dragend", =>
        coords = @yplacemark.geometry.getCoordinates()
        @getAddress coords
        $('.js-lat').val(coords[0])
        $('.js-lon').val(coords[1])
    @getAddress coords

  placeBaloon: ->
    addr = "Санкт-Петербург, #{$(".js-street").val()}  #{$(".js-building").val()}  #{$(".js-adds").val()}"
    ymaps.geocode(addr,
      results: 1
    ).then (res) =>
      firstGeoObject = res.geoObjects.get(0)
      coords = firstGeoObject.geometry.getCoordinates()
      $('.js-lat').val(coords[0])
      $('.js-lon').val(coords[1])
      @addPlacemark coords

