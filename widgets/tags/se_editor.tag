<pb-se-editor>

  <h1 show={item.title}>Objekt '{item.title}' bearbeiten</h1>
  <h1 show={!item}>Objekt erstellen</h1>

  <hr />

  <form onsubmit={submit}>

    <div class="row">
      <div class="six columns">
        <pb-input
          label="Objektbezeichnung"
          name="title"
          value={item.title}
          errors={errors.title}
        />
        <pb-input
          label="Fortlaufende Nummer"
          name="sequence"
          value={item.sequence}
          errors={errors.sequence}
        />
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
        <pb-autocomplete
          label="Markierungen"
          name="markings"
          value={item.markings}
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
    </div>

    <hr />

    <div class="row">
      <div class="four columns">
        <pb-input
          label="Höhe ohne Sockel (in cm)"
          name="height"
          value={item.height}
        />
        <pb-input
          label="Höhe mit Sockel (in cm)"
          name="height_with_socket"
          value={item.height_with_socket}
        />
        <pb-input
          label="Gewicht (in kg)"
          name="weight"
          value={item.weight}
        />
      </div>
      <div class="four columns">
        <pb-input
          label="Breite ohne Sockel (in cm)"
          name="width"
          value={item.width}
        />
        <pb-input
          label="Breite mit Sockel (in cm)"
          name="width_with_socket"
          value={item.width_with_socket}
        />
        <pb-input
          label="Durchmesser (in cm)"
          name="diameter"
          value={item.diameter}
        />
      </div>
      <div class="four columns">
        <pb-input
          label="Tiefe ohne Sockel (in cm)"
          name="depth"
          value={item.depth}
        />
        <pb-input
          label="Tiefe mit Sockel (in cm)"
          name="depth_with_socket"
          value={item.depth_with_socket}
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

    <pb-media-dropzone media={item.media} sub-entry-id={opts.id} />

    <hr />

    <div class="u-text-right">
      <input type="submit" class="button-primary" value="Speichern" />
      <input type="reset" class="button" value="Abbrechen" />
    </div>

  </form>

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      if self.opts.id
        $.ajax(
          type: 'get'
          url: "/api/ses/#{self.opts.id}"
          success: (data) ->
            console.log data
            self.item = data
            self.update()
        )

    form_data = ->
      result = {}
      for element in $(self.root).find("[name]")
        e = $(element)
        result[e.attr('name')] = e.val()
      result.main_entry_id = self.opts.main_entry_id
      result

    self.submit = (event) ->
      event.preventDefault()

      if self.opts.id
        $.ajax(
          type: 'put'
          url: "/api/ses/#{self.opts.id}"
          data: JSON.stringify(sub_entry: form_data())
          success: (data) ->
            console.log data
          error: (request) ->
            console.log JSON.parse(request.response)
        )
      else
        $.ajax(
          type: 'post'
          url: "/api/ses"
          data: JSON.stringify(sub_entry: form_data())
          success: (data) ->
            console.log data
            self.errors = undefined
            riot.route '/mes'
          error: (request) ->
            data = JSON.parse(request.response)
            console.log data
            self.errors = data.errors
          complete: ->
            self.update()
        )


  </script>

</pb-se-editor>