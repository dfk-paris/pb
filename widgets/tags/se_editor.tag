<pb-se-editor>

  <h1 if={item} show={item.title}>Unterobjekt '{item.title}' bearbeiten</h1>
  <h1 if={item} show={!item.id}>Unterobjekt hinzufügen</h1>

  <hr />

  <form onsubmit={submit} if={item && main_entry}>

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
            ref="noTitle"
            onchange={noTitleHandler}
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
          label="Gewicht"
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
          label="Durchmesser"
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
          <pb-image-viewer url={medium.urls.normal} />
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

  <script type="text/coffee">
    tag = this
    tag.id = -> wApp.routing.query()['id']
    tag.main_entry_id = -> wApp.routing.query()['main_entry_id']
    # tag.main_entry = {}
    tag.errors = {}
    # tag.item = {}
    window.t = tag

    tag.on 'mount', ->
      wApp.bus.on 'pb-load-data', -> tag.load_data()
      tag.load_data()

    tag.noTitleHandler = (event) ->
      tag.hide_title_field = tag.refs.noTitle.value()
      tag.update()

    tag.load_data = ->
      Zepto.ajax(
        type: 'get'
        url: "/api/mes/#{tag.main_entry_id()}"
        success: (data) ->
          tag.main_entry = data
          tag.update()
      )

      if tag.opts.id
        Zepto.ajax(
          type: 'get'
          url: "/api/ses/#{tag.opts.id}"
          success: (data) ->
            # console.log data
            tag.item = data
            tag.hide_title_field = data.no_title
            tag.update()
        )
      else
        Zepto.ajax(
          type: 'get'
          url: "/api/mes/#{tag.opts.main_entry_id}"
          success: (data) ->
            # console.log data
            tag.item = {
              inventory_ids: []
              media: []
              main_entry: data
            }
            tag.update()
        )

    form_data = ->
      result = {
        main_entry_id: tag.main_entry_id()
        no_title: tag.refs.noTitle.value()
      }
      for element in Zepto(tag.root).find("input[name], textarea[name]")
        e = Zepto(element)
        result[e.attr('name')] = e.val()
      for element in Zepto(tag.root).find("input[type=checkbox][name]")
        e = Zepto(element)
        result[e.attr('name')] = e.prop('checked')
      result

    tag.pre_submit = (where) ->
      (event) ->
        tag.where = where
        true

    tag.submit = (event) ->
      event.preventDefault()

      if tag.id()
        Zepto.ajax(
          type: 'put'
          url: "/api/ses/#{tag.id()}"
          data: JSON.stringify(sub_entry: form_data())
          success: (data) ->
            if tag.where == 'back'
              route '/mes'
            else
              tag.item = data.sub_entry
              tag.update()
          error: (request) ->
            tag.errors = data.errors
          complete: ->
            tag.update()
        )
      else
        Zepto.ajax(
          type: 'post'
          url: "/api/ses"
          data: JSON.stringify(sub_entry: form_data())
          success: (data) ->
            if tag.where == 'back'
              route '/mes'
            else
              route "/ses/form?main_entry_id=#{tag.main_entry_id()}&id=#{data.sub_entry.id}"
              tag.item = data.sub_entry
              tag.update()
          error: (request) ->
            data = JSON.parse(request.response)
            tag.errors = data.errors
          complete: ->
            tag.update()
        )

    tag.edit_medium =(medium) ->
      (event) ->
        wApp.bus.trigger 'modal', 'pb-file-editor', {
          'subEntryId': tag.opts.id
          'item': medium
        }

    tag.remove_medium = (medium) ->
      (event) ->
        event.preventDefault()
        Zepto.ajax(
          type: 'delete'
          url: "/api/ses/#{medium.sub_entry_id}/media/#{medium.id}"
          success: ->
            wApp.bus.trigger 'pb-load-data'
        )


  </script>

</pb-se-editor>