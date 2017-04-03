ready = ->

  $(document).foundation();

jQuery ->
  tz = jstz.determine()
  $.cookie 'timezone', tz.name(), path: '/'
  return

$(document).on('turbolinks:load', ready)