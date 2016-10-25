<pb-me-editor>

  <h1 show={item.title}>Haupt-Eintrag '{item.title}' bearbeiten</h1>
  <h1 show={!item}>Haupt-Eintrag erstellen</h1>

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
        <pb-location-select
          label="Raum / Ort der Aufbewahrung"
          name="location"
          value={item.location}
        />
      </div>
    </div>

    <pb-input
      label="Diesen Eintrag veröffentlichen"
      name="publish"
      type="checkbox"
      value={item.publish}
    />

    <hr />

    <pb-textarea
      label="Herkunft / Provenienz"
      name="provenience"
      value={item.provenience}
    />

    <pb-textarea
      label="Historische Nachweise"
      name="historical_evidence"
      value={item.historical_evidence}
    />

    <pb-textarea
      label="Literatur"
      name="literature"
      value={item.literature}
    />

    <pb-textarea
      label="Beschreibung"
      name="description"
      value={item.description}
    />

    <pb-textarea
      label="Würdigung"
      name="appreciation"
      value={item.appreciation}
    />

    <hr />

    <div class="u-text-right">
      <input type="submit" class="button-primary" value="Speichern" />
    </div>

  </form>

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      if self.id()
        $.ajax(
          type: 'get'
          url: "/api/mes/#{self.id()}"
          success: (data) ->
            # console.log data
            self.item = data
            self.update()
        )

    form_data = ->
      result = {}
      for element in $(self.root).find("[name]")
        e = $(element)
        if e.attr('type') == 'checkbox'
          result[e.attr('name')] = e.prop('checked')
        else
          result[e.attr('name')] = e.val()
      result

    self.id = -> wApp.routing.query()['id']

    self.submit = (event) ->
      event.preventDefault()

      if self.id()
        $.ajax(
          type: 'put'
          url: "/api/mes/#{self.item.id}"
          data: JSON.stringify(main_entry: form_data())
          success: (data) ->
            riot.route 'mes'
          error: (request) ->
            data = JSON.parse(request.response)
            self.errors = data.errors
          complete: ->
            self.update()
        )
      else
        $.ajax(
          type: 'post'
          url: "/api/mes"
          data: JSON.stringify(main_entry: form_data())
          success: (data) ->
            riot.route 'mes', undefined, true
          error: (request) ->
            data = JSON.parse(request.response)
            self.errors = data.errors
          complete: ->
            self.update()
        )


  </script>

</pb-me-editor>