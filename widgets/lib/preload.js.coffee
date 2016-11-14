Zepto.ajax(
  type: 'get'
  url: "/api/locations"
  success: (data) ->
    wApp.data.locations = {}
    for group in data
      for room in group.rooms
        wApp.data.locations[room.id] = room.name
    riot.update()
)
