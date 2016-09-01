<pb-mes-table>

  <h1>Objekte</h1>

  <div class="u-text-right">
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
        <h4>{me.sequence} {me.title || me.id}</h4>
        <span show={me.location} class="pb-location">
          <strong>Raum / Ort der Aufbewahrung:</strong>
          <pb-location id={me.location} />
        </span>
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
              <img src={se.media[0].urls.thumb} />
            </div>
            <strong>{se.sequence} {se.title}</strong>
            <div show={se.inventory_ids.length > 0}>
              <pb-badge-list
                values={se.inventory_ids}
                highlight={params('inventory')}
              />
            </div>
          </div>
          <div class="u-cf"></div>
        </div>
      </div>

      <div class="u-cf"></div>
    </li>
  </ul>

  <style type="text/scss">
    @import "widgets/styles/vars.scss";
  
    pb-mes-table, [data-is=pb-mes-table] {
      & > form {
        margin-bottom: 0rem;
      }

      & > ul {
        list-style-type: none;

        & > li {
          border-top: 1px solid $gray;
          padding-top: 2rem;
          padding-bottom: 2rem;

          h4 {
            margin-bottom: 0rem;
          }
        }
      }

      .main-entry {
        .pb-location {
          position: relative;
          top: -10px;
          font-size: 1.2rem;
        }
      }

      .sub-entry {
        padding: 0.8rem;

        &:hover {
          background-color: $highlight;
          border-radius: 0.5rem;
        }

        .media {
          width: 80px;
          min-height: 10px;
          margin-right: 1rem;
          line-height: 0px;
          font-size: 0px;

          img {
            border-radius: 0.5rem;
          }
        }
      }
    }
  </style>

  <script type="text/coffee">
    self = this
    window.s = self

    self.params = (key = undefined) ->
      result = {
        page: (wApp.routing.query() || {})['page'] || 1
        title: wApp.routing.query()['title']
        location: wApp.utils.to_integer(wApp.routing.query()['location'])
        creator: wApp.routing.query()['creator']
        inventory: wApp.routing.query()['inventory']
      }
      if key then result[key] else result

    self.search = (event) -> 
      event.preventDefault()
      wApp.routing.query(
        title: self.tags.title.value()
        location: self.tags.location.value()
        creator: self.tags.creator.value()
        inventory: self.tags.inventory.value()
      )

    self.fetch = ->
      $.ajax(
        type: 'get'
        url: 'api/mes'
        data: self.params()
        success: (data) ->
          self.data = data
          self.update()
      )

    self.on 'mount', -> self.fetch()
    wApp.bus.on 'routing:query', ->
      self.fetch()

    self.remove_main_entry = (me) ->
      (event) ->
        event.preventDefault()
        if confirm("Sicher?")
          $.ajax(
            type: 'delete'
            url: "api/mes/#{me.id}"
            success: (data) ->
              self.fetch()
          )

    self.remove_sub_entry = (se) ->
      (event) ->
        event.preventDefault()
        if confirm("Sicher?")
          $.ajax(
            type: 'delete'
            url: "api/ses/#{se.id}"
            success: (data) ->
              self.fetch()
          )


  </script>

</pb-mes-table>