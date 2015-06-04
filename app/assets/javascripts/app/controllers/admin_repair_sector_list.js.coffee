class App.AdminRepairSectorList extends Spine.Controller

  events:
    'click  .js-open-types' : 'openType'
    'click  .js-close-types' : 'closeType'
    'click  .js-open-jobs' : 'openJob'
    'click  .js-close-jobs' : 'closeJob'

  constructor: ->
    super

  openType: (e) ->
    return if @$(".js-repair-sector-type-#{$(e.target).data("sector-id")}").length > 0
    $.get "/admin/repair_work_types?sector_id=#{$(e.target).data("sector-id")}", (data) =>
      return if @$(".js-repair-sector-type-#{$(e.target).data("sector-id")}").length > 0
      $(e.target).parents("tr").after data

  closeType: (e) ->
    @$(".js-repair-sector-type-#{$(e.target).data("sector-id")}").remove()

  openJob: (e) ->
    return if @$(".js-repair-sector-type-job-#{$(e.target).data("type-id")}").length > 0
    $.get "/admin/repair_work_jobs?type_id=#{$(e.target).data("type-id")}", (data) =>
      return if @$(".js-repair-sector-type-job-#{$(e.target).data("type-id")}").length > 0
      $(e.target).parents("tr").after data

  closeJob: (e) ->
    @$(".js-repair-sector-type-job-#{$(e.target).data("type-id")}").remove()
