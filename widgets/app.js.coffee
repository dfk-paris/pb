Dropzone.autoDiscover = false

wAppApiUrl = Zepto('script[pb-api-url]').attr('pb-api-url') || ''

Zepto.extend Zepto.ajaxSettings, {
  dataType: 'json'
  contentType: 'application/json'
  beforeSend: (xhr, settings) ->
    settings.url = "#{wAppApiUrl}#{settings.url}"
}

Zepto(document).on 'contextmenu', 'img', (event) ->
  event.preventDefault()
  # console.log event

window.wApp = {
  bus: riot.observable()
  data: {}
  setup: (tags = '*') ->
    Zepto.ajax(
      type: 'get'
      url: "/api/locations"
      success: (data) ->
        wApp.data.locationList = data
        wApp.data.locations = {}
        for group in data
          for room in group.rooms
            wApp.data.locations[room.id] = room.name

        riot.mount(tags)
        wApp.routing.setup()
    )
}
