<pb-search-form>

  <form onsubmit={search}>
    <div class="row">
      <div class="one-third column">
        <pb-input
          placeholder="Objektbezeichnung"
          ref="title"
          value={params('title')}
        />
      </div>
      <div class="one-third column">
        <pb-location-select
          ref="location"
          value={params('location')}
          prompt={true}
        />
      </div>
      <div class="one-third column">
        <pb-autocomplete
          placeholder="Personen"
          name="creator"
          ref="creator"
          value={params('creator')}
        />
      </div>
    </div>

    <div class="row">
      <div class="one-third column">
        <pb-input
          placeholder="Inventar"
          ref="inventory"
          value={params('inventory')}
        />
      </div>
      <div class="two-thirds column u-text-right">
        <input type="submit" class="button" value="Suchen"></input>
      </div>
    </div>
  </form>

  <script type="text/coffee">
    tag = this

    tag.search = (event) ->
      event.preventDefault()
      data = {
        page: 1
        title: tag.refs.title.value()
        location: tag.refs.location.value()
        creator: tag.refs.creator.value()
        inventory: tag.refs.inventory.value()
      }
      wApp.routing.query(data)

    tag.params = (key = undefined) ->
      result = {
        page: (wApp.routing.query() || {})['page'] || 1
        title: wApp.routing.query()['title']
        location: wApp.utils.to_integer(wApp.routing.query()['location'])
        creator: wApp.routing.query()['creator']
        inventory: wApp.routing.query()['inventory']
        unpublished: true
      }
      if key then result[key] else result
  </script>

</pb-search-form>