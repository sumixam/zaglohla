class App.AdminBrands extends Spine.Controller

  events:
    'click .js-category-open' : 'openCategory'
    'click .js-brand-open' : 'openBrand'
    'click .js-model-open' : 'openModel'
    'click .js-generation-open' : 'openGeneration'
    'click .js-rm-all-button': 'rmAll'

  constructor: ->
    super
    prms = []
    for c in @getCookie("admin_categories")
      prms.push @getCategory(c)
    Promise.all(prms).then =>
      prms = []
      for c in @getCookie("admin_brands")
        prms.push @getBrand(c)
      Promise.all(prms).then =>
        prms = []
        for c in @getCookie("admin_models")
          prms.push @getModel(c)
        Promise.all(prms).then =>
          prms = []
          for c in @getCookie("admin_generations")
            prms.push @getGeneration(c)
          Promise.all(prms).then =>
            console.log "finally"

  openCategory: (e) ->
    $(e.target).data("status", "loading")
    $(e.target).html("...")
    @getCategory($(e.target).data("cid"))

  getCategory: (id) ->
    new Promise (resolve, reject) =>
      if $(".js-cat-#{id}").length == 0
        do resolve
      else
        $.get("/admin/brand_brands?ca=#{id}").then (data) =>
          @addCookie "admin_categories", id
          $(".js-cat-#{id} .js-category-open").data("status", "opened")
          $(".js-cat-#{id} .js-category-open").html("")
          $(".js-cat-#{id}").after(data)
          do resolve

  openBrand: (e) ->
    $(e.target).data("status", "loading")
    $(e.target).html("...")
    @getBrand($(e.target).data("cid"))

  getBrand: (id) ->
    new Promise (resolve, reject) =>
      if $(".js-brnd-#{id}").length == 0
        do resolve
      else
        $.get("/admin/model_brands?ca=#{id}").then (data) =>
          @addCookie "admin_brands", id
          $(".js-brnd-#{id} .js-brand-open").data("status", "opened")
          $(".js-brnd-#{id} .js-brand-open").html("")
          $(".js-brnd-#{id}").after(data)
          do resolve

  openModel: (e) ->
    console.log $(e.target).data("cid")
    $(e.target).data("status", "loading")
    $(e.target).html("...")
    @getModel($(e.target).data("cid"))


  getModel: (id) ->
    new Promise (resolve, reject) =>
      if $(".js-mdl-#{id}").length == 0
        do resolve
      else
        $.get("/admin/generation_brands?ca=#{id}").then (data) =>
          @addCookie "admin_models", id
          $(".js-mdl-#{id} .js-model-open").data("status", "opened")
          $(".js-mdl-#{id} .js-model-open").html("")
          $(".js-mdl-#{id}").after(data)
          do resolve

  openGeneration: (e) ->
    $(e.target).data("status", "loading")
    $(e.target).html("...")
    @getGeneration($(e.target).data("cid"))

  getGeneration: (id) ->
    new Promise (resolve, reject) =>
      if $(".js-gnrs-#{id}").length == 0
        do resolve
      else
        $.get("/admin/engine_brands?ca=#{id}").then (data) =>
          @addCookie "admin_generations", id
          $(".js-gnrs-#{id} .js-generation-open").data("status", "opened")
          $(".js-gnrs-#{id} .js-generation-open").html("")
          $(".js-gnrs-#{id}").after(data)
          do resolve

  rmAll: ->
    data =
      brands: []
      models: []
      generations: []
      engines: []
    $(".js-rm-all").each (i, el) ->
      if $(el).prop("checked")
        if $(el).data("btype") == "brand"
          data.brands.push $(el).val()
        if $(el).data("btype") == "model"
          data.models.push $(el).val()
        if $(el).data("btype") == "generation"
          data.generations.push $(el).val()
        if $(el).data("btype") == "engine"
          data.engines.push $(el).val()
    $.post('/admin/brands/rmall', data).then ->
      location.reload()

  addCookie: (name, value) ->
    return if @getCookie(name).indexOf(value) != -1
    $.cookie name, JSON.stringify(@getCookie(name).concat([value]))

  getCookie: (name) ->
    return [] unless $.cookie(name)
    return [] if $.cookie(name) == ""
    JSON.parse $.cookie(name)
