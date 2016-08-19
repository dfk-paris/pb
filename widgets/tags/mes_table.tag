<pb-mes-table>

  <h1>Objekte</h1>

  <form>
    <div class="row">
      <div class="one-third column">
        <input
          class="u-full-width"
          type="text"
          name="terms"
          placeholder="Search everywhere"
        />
      </div>
      <div class="one-third column">
        <a onclick={toggle_criteria}>more …</a>
      </div>
    </div>

    <div class="criteria" if={criteria_visible}>
      <div class="row">
        <div class="one-third column">
          <input
            class="u-full-width"
            type="text"
            name="account_number"
            placeholder="Konto-Nr"
          />
        </div>
        <div class="one-third column">
          <input
            class="u-full-width"
            type="text"
            name="inventory"
            placeholder="Inventarbezeichnung"
          />
        </div>
      </div>

      <div class="row">
        <div class="one-third column">
          <input
            class="u-full-width"
            type="text"
            name="name"
            placeholder="Objektbezeichnung"
          />
        </div>
        <div class="one-third column">
          <input
            class="u-full-width"
            type="text"
            name="location"
            placeholder="Aufstellungsort"
          />
        </div>
        <div class="one-third column">
          <pb-people-autocomplete />
        </div>
      </div>
    </div>
  </form>

  <div class="pagination u-text-right">
    <i class="fa fa-chevron-circle-left"></i> |
    <i class="fa fa-chevron-circle-right"></i>
  </div>

  <ul class="u-full-width">
    <li each={me in main_entries}>
      <div class="main-entry">
        <div class="u-pull-right">
          <pb-button
            href="#/mes/edit?id={me.id}"
            icon="edit"
            label="bearbeiten"
          />
          <pb-button
            href="#/mes/remove?id={me.id}"
            icon="remove"
            label="löschen"
          />
        </div>
        <h4>{me.sequence} {me.title}</h4>
        <span show={me.location} class="pb-location">
          <strong>Raum / Ort der Aufbewahrung:</strong>
          <pb-location id={me.location} />
        </span>
      </div>
      <div class="sub-entries">
        <div each={se in me.sub_entries}>
          <div class="u-pull-right">
            <pb-button
              href="#/ses/edit?id={se.id}"
              icon="edit"
              label="bearbeiten"
            />
            <pb-button
              href="#/ses/remove?id={se.id}"
              icon="remove"
              label="löschen"
            />
          </div>
          <div class="metadata">
            <i class="fa fa-arrow-circle-right"></i>
            <div class="media u-pull-left" show={se.media.length > 0}>
              <img src={se.media[0].urls.thumb} />
            </div>
            <strong>{se.sequence} {se.title}</strong>
            <div show={se.inventory_ids.length > 0}>
              <pb-badge-list values={se.inventory_ids} />
            </div>
          </div>
          <div class="u-cf"></div>
        </div>
      </div>

      <div class="u-cf"></div>
    </li>
  </ul>

  <style type="text/scss">
    @import "widgets/vars.scss";
  
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

      .sub-entries {
        & > div {
          padding: 0.8rem;
        }

        & > div:hover {
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

    self.toggle_criteria = (event) ->
      event.preventDefault()
      self.criteria_visible = !self.criteria_visible

    group = (data) ->
      mes = {}
      for se in data
        me_id = se.main_entry.id
        mes[me_id] ||= se.main_entry
        mes[me_id]['sub_entries'] ||= []
        mes[me_id]['sub_entries'].push se
      results = []
      for id, me of mes
        results.push me
      results

    self.on 'mount', ->
      $.ajax(
        type: 'get'
        url: 'api/ses'
        success: (data) ->
          console.log data
          self.main_entries = group(data)
          self.update()
      )
  </script>

</pb-mes-table>