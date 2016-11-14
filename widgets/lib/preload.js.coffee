$.ajax(
  type: 'get'
  url: "/data/locations.json"
  success: (data) ->
    wApp.data.locations = {}
    for group in data
      for room in group.rooms
        wApp.data.locations[room.id] = room.name
    riot.update()
)
