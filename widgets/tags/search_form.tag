<pb-search-form>

  <form onsubmit={search} onreset={reset}>
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
      only-in-use={true}
    />

    <pb-autocomplete
      placeholder="Künstler"
      name="creator"
      ref="creator"
      value={params('creator')}
    />

    <pb-input
      placeholder="Inventar"
      ref="inventory"
      value={params('inventory')}
    />

    <div class="u-text-right pb-buttons">
      <input type="reset" value="Neue Suche" onclick={reset} />
      <input type="submit" value="Suchen" />
    </div>
  </form>

  <script type="text/coffee">
    tag = this

    tag.search = (event) ->
      event.preventDefault() if event
      data = {
        page: 1
        title: tag.refs.title.value()
        terms: tag.refs.terms.value()
        location: tag.refs.location.value()
        creator: tag.refs.creator.value()
        inventory: tag.refs.inventory.value()
      }
      wApp.routing.query(data)

    tag.reset = (event) ->
      event.preventDefault()
      wApp.routing.path('/')
      Zepto(tag.root).find('input[type=text]').val('')
      Zepto(tag.root).find('select').val('')
      Lockr.set('selected-results')


    tag.params = (key = undefined) ->
      result = {
        page: (wApp.routing.query() || {})['page'] || 1
        per_page: (wApp.routing.query() || {})['per_page'] || 10
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