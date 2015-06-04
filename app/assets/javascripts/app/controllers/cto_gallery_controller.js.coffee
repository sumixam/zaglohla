class App.CtoGalleryController extends App.BaseController

  className: "sk-modal-window o-modal-window st-center-relative invoice-module"

  constructor: ->
    super
    do @render

  render: ->
    $('.js-gallery').magnificPopup({
      type: 'image',
      delegate: 'a',
      gallery:{
        enabled:true
      }
    })
