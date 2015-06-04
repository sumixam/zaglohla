class App.HomeController extends App.BaseController

  constructor: ->
    super
    do @initSlider

  initSlider: ->
    $('.flexslider').flexslider
      animation: "slide"
