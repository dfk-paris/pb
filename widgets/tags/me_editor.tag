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
      </div>
      <div class="six columns">
        <pb-input
          label="Fortlaufende Nummer"
          name="sequence"
          value={item.sequence}
          errors={errors.sequence}
        />
      </div>
    </div>

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
      <input type="reset" class="button" value="Abbrechen" />
    </div>

  </form>

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      if self.opts.id
        $.ajax(
          type: 'get'
          url: "/api/mes/#{self.opts.id}"
          success: (data) ->
            self.item = data
            self.update()
        )

    form_data = ->
      result = {}
      for element in $(self.root).find("[name]")
        e = $(element)
        result[e.attr('name')] = e.val()
      result

    self.submit = (event) ->
      event.preventDefault()

      if self.opts.id
        $.ajax(
          type: 'put'
          url: "/api/mes/#{self.opts.id}"
          data: JSON.stringify(main_entry: form_data())
          success: (data) ->
            console.log data
          error: (request) ->
            console.log JSON.parse(request.response)
        )
      else
        $.ajax(
          type: 'post'
          url: "/api/mes"
          data: JSON.stringify(main_entry: form_data())
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

</pb-me-editor>