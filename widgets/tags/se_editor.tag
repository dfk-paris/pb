<pb-se-editor>

  <h1 show={item.title}>Unterobjekt '{item.title}' bearbeiten</h1>
  <h1 show={!item.id}>Unterobjekt hinzufügen</h1>

  <hr />

  <form onsubmit={submit}>

    <div class="row">
      <div class="six columns">
        <fieldset>
          <pb-input
            if={!hide_title_field}
            label="Objektbezeichnung"
            name="title"
            value={item.title}
            errors={errors.title}
          />
          <pb-input
            if={!hide_title_field}
            label="Fortlaufende Nummer"
            name="sequence"
            value={item.sequence}
            errors={errors.sequence}
          />
          <hr if={!hide_title_field} />
          <strong>Haupteintrag:</strong><br/ >
          <em>{main_entry.title} ({main_entry.sequence})</em>
          <pb-input
            type="checkbox"
            label="Werte aus Haupteintrag übernehmen"
            name="no_title"
            value={item.no_title}
          />
        </fieldset>
      </div>
      <div class="six columns">
        <pb-textarea
          label="Inventarnummern"
          name="inventory_id_list"
          value={item.inventory_ids.join(', ')}
          errors={errors.inventory_ids}
        />
      </div>
    </div>

    <hr />

    <div class="row">
      <div class="six columns">
        <pb-autocomplete
          label="Hersteller / Künstler"
          name="creator"
          value={item.creator}
        />
        <pb-autocomplete
          label="Material"
          name="material"
          value={item.material}
        />
      </div>
      <div class="six columns">
        <pb-autocomplete
          label="Herstellungsort"
          name="location"
          value={item.location}
        />
        <pb-input
          label="Datum"
          name="dating"
          value={item.dating}
        />
      </div>
      <div class="twelve columns">
        <pb-textarea
          label="Markierungen"
          name="markings"
          value={item.markings}
        />
      </div>
    </div>

    <hr />

    <div class="row">
      <div class="four columns">
        <pb-input
          label="Höhe mit ..."
          name="height_with_socket"
          value={item.height_with_socket}
        />
        <pb-input
          label="Höhe ohne ..."
          name="height"
          value={item.height}
        />
        <pb-input
          label="Gewicht (in kg)"
          name="weight"
          value={item.weight}
        />
      </div>
      <div class="four columns">
        <pb-input
          label="Breite mit ..."
          name="width_with_socket"
          value={item.width_with_socket}
        />
        <pb-input
          label="Breite ohne ..."
          name="width"
          value={item.width}
        />
        <pb-input
          label="Durchmesser (in cm)"
          name="diameter"
          value={item.diameter}
        />
      </div>
      <div class="four columns">
        <pb-input
          label="Tiefe mit ..."
          name="depth_with_socket"
          value={item.depth_with_socket}
        />
        <pb-input
          label="Tiefe ohne ..."
          name="depth"
          value={item.depth}
        />
      </div>
    </div>

    <hr />

    <pb-textarea
      label="Restaurierungen"
      name="restaurations"
      value={item.restaurations}
    />

    <hr />

    <div class="u-text-right">
      <input
        type="submit"
        class="button"
        value="Speichern"
        onclick={pre_submit('stay')}
      />
      <input
        type="submit"
        class="button"
        value="Speichern und zurück zur Liste"
        onclick={pre_submit('back')}
      />
    </div>

    <hr if={id()} />

    <h3 if={id()}>Abbildungen</h3>

    <div
      if={id()}
      class="pb-media-grid row"
      each={row in wApp.utils.in_groups_of(4, item.media)}
    >
      <div class="three columns" each={medium in row}>
        <div class="pb-frame {'publish': medium.publish}">
          <img src={medium.urls.normal} />
          <small show={medium.caption}>{medium.caption}</small>
          <hr show={medium.caption} />
          <div class="u-text-right buttons">
            <pb-button
              href="#"
              icon="edit"
              label="bearbeiten"
              class="edit"
              onclick={edit_medium(medium)}
            />
            <pb-button
              href="#"
              icon="remove"
              label="löschen"
              class="remove"
              onclick={remove_medium(medium)}
            />
          </div>
        </div>
      </div>
    </div>

    <pb-media-dropzone
      if={id()}
      media={item.media}
      sub-entry-id={id()}
    />

  </form>

  <style type="text/scss">
    @import "widgets/styles/vars.scss";

    pb-se-editor, [data-is=pb-se-editor] {
      .pb-media-grid {
        .pb-frame {
          padding: 0.5rem;
          border: 1px solid gray;
          margin-bottom: 3rem;

          img {
            display: block;
            width: 100%;
          }

          hr {
            margin-top: 0.5rem;
            margin-bottom: 0.5rem;
          }

          .buttons {
            margin-top: 0.3rem;
          }

          &.publish {
            background-color: $color-secondary-2-4;
          }
        }
      }
    }
  </style>

  <script type="text/coffee">
    self = this
    self.id = -> wApp.routing.query()['id']
    self.main_entry_id = -> wApp.routing.query()['main_entry_id']

    self.on 'mount', ->
      wApp.bus.on 'pb-load-data', -> self.load_data()
      self.load_data()

      $("input[name='no_title']").on 'change', (event) ->
        self.hide_title_field = $(event.target).prop('checked')
        self.update()

    self.load_data = ->
      $.ajax(
        type: 'get'
        url: "/api/mes/#{self.main_entry_id()}"
        success: (data) ->
          self.main_entry = data
          self.update()
      )

      if self.opts.id
        $.ajax(
          type: 'get'
          url: "/api/ses/#{self.opts.id}"
          success: (data) ->
            # console.log data
            self.item = data
            self.hide_title_field = data.no_title
            self.update()
        )
      else
        $.ajax(
          type: 'get'
          url: "/api/mes/#{self.opts.main_entry_id}"
          success: (data) ->
            # console.log data
            self.item = {main_entry: data}
            self.update()
        )

    form_data = ->
      result = {
        main_entry_id: self.main_entry_id()
        no_title: $("input[name=no_title]").prop('checked')
      }
      for element in $(self.root).find("input[name], textarea[name]")
        e = $(element)
        result[e.attr('name')] = e.val()
      for element in $(self.root).find("input[type=checkbox][name]")
        e = $(element)
        result[e.attr('name')] = e.prop('checked')
      result

    self.pre_submit = (where) ->
      (event) ->
        self.where = where
        true

    self.submit = (event) ->
      event.preventDefault()

      if self.id()
        $.ajax(
          type: 'put'
          url: "/api/ses/#{self.id()}"
          data: JSON.stringify(sub_entry: form_data())
          success: (data) ->
            if self.where == 'back'
              riot.route '/mes'
            else
              self.item = data.sub_entry
              self.update()
          error: (request) ->
            self.errors = data.errors
          complete: ->
            self.update()
        )
      else
        $.ajax(
          type: 'post'
          url: "/api/ses"
          data: JSON.stringify(sub_entry: form_data())
          success: (data) ->
            if self.where == 'back'
              riot.route '/mes'
            else
              riot.route "/ses/form?main_entry_id=#{self.main_entry_id()}&id=#{data.sub_entry.id}"
              self.item = data.sub_entry
              self.update()
          error: (request) ->
            data = JSON.parse(request.response)
            self.errors = data.errors
          complete: ->
            self.update()
        )

    self.edit_medium =(medium) ->
      (event) ->
        wApp.bus.trigger 'modal', 'pb-file-editor', {
          'subEntryId': self.opts.id
          'item': medium
        }

    self.remove_medium = (medium) ->
      (event) ->
        event.preventDefault()
        $.ajax(
          type: 'delete'
          url: "/api/ses/#{medium.sub_entry_id}/media/#{medium.id}"
          success: ->
            wApp.bus.trigger 'pb-load-data'
        )


  </script>

</pb-se-editor>