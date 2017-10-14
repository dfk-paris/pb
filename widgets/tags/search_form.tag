<pb-search-form>

  <form onsubmit={search}>
    <pb-input
      placeholder="Volltextsuche"
      ref="terms"
      value={params('terms')}
      autofocus={true}
    />

    <pb-input
      placeholder="Objektbezeichnung"
      ref="title"
      value={params('title')}
    />

    <pb-location-select
      ref="location"
      value={params('location')}
      prompt={true}
    />

    <pb-autocomplete
      placeholder="Personen"
      name="creator"
      ref="creator"
      value={params('creator')}
    />

    <pb-input
      placeholder="Inventar"
      ref="inventory"
      value={params('inventory')}
    />

    <div class="u-text-right">
      <input type="reset" value="Neue Suche" />
      <input type="submit" value="Suchen" />
    </div>
  </form>

  <script type="text/coffee">
    tag = this

    tag.search = (event) ->
      event.preventDefault()
      data = {
        page: 1
        title: tag.refs.title.value()
        terms: tag.refs.terms.value()
        location: tag.refs.location.value()
        creator: tag.refs.creator.value()
        inventory: tag.refs.inventory.value()
      }
      wApp.routing.query(data)

    tag.params = (key = undefined) ->
      result = {
        page: (wApp.routing.query() || {})['page'] || 1
        title: wApp.routing.query()['title']
        terms: wApp.routing.query()['terms']
        location: wApp.utils.to_integer(wApp.routing.query()['location'])
        creator: wApp.routing.query()['creator']
        inventory: wApp.routing.query()['inventory']
        unpublished: true
      }
      if key then result[key] else result
  </script>

</pb-search-form>