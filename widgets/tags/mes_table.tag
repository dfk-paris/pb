<pb-mes-table>

  <h1>Objekte</h1>

  <div class="u-text-right">
    <!-- <a href="#" onclick={new_me} class="button">Neuer Eintrag</a> -->
    
    <a href="#/mes/form" class="button">Neuer Eintrag</a>
  </div>

  <hr />

  <form onsubmit={search}>
    <div class="row">
      <div class="one-third column">
        <pb-input
          placeholder="Objektbezeichnung"
          name="title"
          value={params('title')}
        />
      </div>
      <div class="one-third column">
        <pb-location-select
          name="location"
          value={params('location')}
          prompt={true}
        />
      </div>
      <div class="one-third column">
        <pb-autocomplete
          placeholder="Personen"
          name="creator"
          value={params('creator')}
        />
      </div>
    </div>

    <div class="row">
      <div class="one-third column">
        <pb-input
          placeholder="Inventar"
          name="inventory"
          value={params('inventory')}
        />
      </div>
      <div class="two-thirds column u-text-right">
        <input type="submit" class="button" value="Suchen"></input>
      </div>
    </div>

    <div class="row">
      <div class="one-third column">
        <pb-input
          label="Daten anzeigen"
          name="show_data"
          type="checkbox"
          onchange={toggleDataVisibility}
        />
      </div>
      <div class="one-third column">
        <pb-input
          label="leere Felder anzeigen"
          name="show_empty_fields"
          type="checkbox"
          onchange={toggleEmptyFieldVisibility}
        />
      </div>
    </div>
  </form>

  <pb-pagination
    total={data.total}
    page={params('page')}
    per_page={10}
    onchange={page_to}
  />

  <ul class="u-full-width">
    <li each={me in data.items}>
      <div class="main-entry">
        <div class="u-pull-right">
          <pb-button
            href="#/ses/form?main_entry_id={me.id}"
            icon="plus"
            label="Unterobjekt hinzufügen"
          />
          <pb-button
            href="#/mes/form?id={me.id}"
            icon="edit"
            label="bearbeiten"
          />
          <pb-button
            href="#/mes/{me.id}"
            icon="remove"
            label="löschen"
            onclick={remove_main_entry(me)}
          />
        </div>
        <h4>
          {me.sequence} {me.title || me.id}
          <i show={me.publish} class="fa fa-eye"></i>
          <i show={!me.publish} class="fa fa-eye-slash"></i>
        </h4>
        <div show={me.location} class="pb-location">
          <strong>Raum / Ort der Aufbewahrung:</strong>
          <pb-location id={me.location} />
        </div>
        <div class="pb-timestamp">
          <strong>Letztes Update:</strong>
          <w-timestamp value={me.updated_at} />
        </div>

        <div class="pb-data" show={showData}>
          <pb-string-value
            label="Herkunft / Provenienz"
            value={me.provenience}
            show-if-empty={showEmptyFields}
          />
          <pb-string-value
            label="Historische Nachweise"
            value={me.historical_evidence}
            show-if-empty={showEmptyFields}
          />
          <pb-string-value
            label="Literatur"
            value={me.literature}
            show-if-empty={showEmptyFields}
          />
          <pb-string-value
            label="Beschreibung"
            value={me.description}
            show-if-empty={showEmptyFields}
          />
          <pb-string-value
            label="Würdigung"
            value={me.appreciation}
            show-if-empty={showEmptyFields}
          />
        </div>
      </div>
      <div class="sub-entries">
        <div each={se in me.sub_entries} class="sub-entry">
          <div class="u-pull-right">
            <pb-button
              href="#/ses/form?main_entry_id={me.id}&id={se.id}"
              icon="edit"
              label="bearbeiten"
            />
            <pb-button
              href="#/ses/{se.id}"
              icon="remove"
              label="löschen"
              onclick={remove_sub_entry(se)}
            />
          </div>
          <div class="metadata">
            <i class="fa fa-arrow-circle-right"></i>
            <div class="media u-pull-left" show={se.media.length > 0}>
              <img
                each={medium in se.media}
                src={medium.urls.thumb}
                src-large={medium.urls.big}
              />
            </div>
            <strong>{se.sequence} {se.title}</strong>
            <div class="pb-timestamp">
              <strong>Letztes Update:</strong>
              <w-timestamp value={se.updated_at} />
            </div>
            <div show={se.inventory_ids.length > 0}>
              <pb-badge-list
                values={se.inventory_ids}
                highlight={params('inventory')}
              />
            </div>
            <div class="pb-data" show={showData}>
              <pb-string-value
                label="Markierungen"
                value={se.markings}
                show-if-empty={showEmptyFields}
              />
              <pb-string-value
                label="Restaurierungen"
                value={se.restaurations}
                show-if-empty={showEmptyFields}
              />
            </div>
          </div>
          <div class="u-cf"></div>
        </div>
      </div>

      <div class="u-cf"></div>
    </li>
  </ul>

  <script type="text/coffee">
    self = this
    self.showData = false
    self.showEmptyFields = false
    window.t = self

    self.on 'mount', -> self.fetch()

    self.params = (key = undefined) ->
      result = {
        page: (wApp.routing.query() || {})['page'] || 1
        title: wApp.routing.query()['title']
        location: wApp.utils.to_integer(wApp.routing.query()['location'])
        creator: wApp.routing.query()['creator']
        inventory: wApp.routing.query()['inventory']
        unpublished: true
      }
      if key then result[key] else result

    self.search = (event) -> 
      event.preventDefault()
      wApp.routing.query(
        page: 1
        title: self.tags.title.value()
        location: self.tags.location.value()
        creator: self.tags.creator.value()
        inventory: self.tags.inventory.value()
      )

    self.fetch = ->
      Zepto.ajax(
        type: 'get'
        url: '/api/mes'
        data: self.params()
        success: (data) ->
          self.data = data
          self.update()
      )

    wApp.bus.on 'routing:query', ->
      self.fetch()

    self.remove_main_entry = (me) ->
      (event) ->
        event.preventDefault()
        if confirm("Sicher?")
          Zepto.ajax(
            type: 'delete'
            url: "/api/mes/#{me.id}"
            success: (data) ->
              self.fetch()
          )

    self.remove_sub_entry = (se) ->
      (event) ->
        event.preventDefault()
        if confirm("Sicher?")
          Zepto.ajax(
            type: 'delete'
            url: "/api/ses/#{se.id}"
            success: (data) ->
              self.fetch()
          )

    self.new_me = (event) ->
      event.preventDefault()
      riot.route 'mes/form'

    self.toggleDataVisibility = (event) ->
      self.showData = Zepto(event.target).prop('checked')
      self.update()

    self.toggleEmptyFieldVisibility = (event) ->
      self.showEmptyFields = Zepto(event.target).prop('checked')
      self.update()


  </script>

</pb-mes-table>