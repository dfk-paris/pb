<pb-file-editor>

  <h3>Zusatzinformationen bearbeiten</h3>

  <form onsubmit={submit} onreset={reset} if={opts.item}>
    <div class="row">
      <div class="twelve columns">
        <pb-textarea
          label="Bildunterschrift"
          name="caption"
          value={opts.item.caption}
          errors={errors.caption}
        />
        <pb-input
          label="Fortlaufende Nummer"
          name="sequence"
          value={opts.item.sequence}
        />
        <pb-input
          type="checkbox"
          label="Öffentlich"
          name="publish"
          value={opts.item.publish}
        />
      </div>
    </div>

    <div class="u-text-right">
      <input type="submit" class="button" value="Speichern" />
      <input type="reset" class="button" value="Abbrechen" />
    </div>
  </form>

  <script type="text/coffee">
    tag = this
    tag.errors = {}

    form_data = ->
      result = {}
      for element in Zepto(tag.root).find("[name]")
        e = Zepto(element)
        result[e.attr('name')] = e.val()
      for element in Zepto(tag.root).find("input[type=checkbox][name]")
        e = Zepto(element)
        result[e.attr('name')] = e.prop('checked')
      result

    tag.submit = (event) ->
      event.preventDefault()

      Zepto.ajax(
        type: 'put'
        url: "/api/ses/#{tag.opts.subEntryId}/media/#{tag.opts.item.id}"
        data: JSON.stringify(medium: form_data())
        success: (data) ->
          # console.log data
          tag.errors = {}
          tag.update()
          tag.reset()
          wApp.bus.trigger 'pb-load-data'
        error: (request) ->
          data = JSON.parse(request.response)
          # console.log data
          tag.errors = data.errors
          tag.update()
      )

    tag.reset = (event) ->
      tag.opts.modal.trigger 'close'

  </script>

</pb-file-editor>