class App.LandingSearch extends App.BaseController

  events:
    'click .js-search-cto' : 'searchCto'


  constructor: ->
    super
    do @initSelect2

  searchCto: ->
    car_brand = $('select.js-cto-car-brand').val()
    location  = $('select.js-cto-location').val()
    if car_brand and car_brand.length > 0
      if location and location.length > 0
        url = "/ctos/brands/#{car_brand}/locations/#{location}"
      else
        url = "/ctos/brands/#{car_brand}"
    else
      if location and location.length > 0
        url = "/ctos/locations/#{location}"
      else
        url = "/ctos"
    window.location.replace url
