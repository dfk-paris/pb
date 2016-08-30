<pb-file-editor>

  <h3>Zusatzinformationen bearbeiten</h3>

  <form onsubmit={submit} onreset={reset}>
    <div class="row">
      <div class="twelve columns">
        <pb-textarea
          label="Bildunterschrift"
          name="caption"
          value={opts.item.caption}
          errors={errors.caption}
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


  <style type="text/scss">
    pb-file-editor, [data-is=pb-file-editor] {
      padding: 2rem;

      form {
        margin-bottom: 0px;
      }
    }
  </style>

  <script type="text/coffee">
    self = this

    form_data = ->
      result = {}
      for element in $(self.root).find("[name]")
        e = $(element)
        result[e.attr('name')] = e.val()
      for element in $(self.root).find("input[type=checkbox][name]")
        e = $(element)
        result[e.attr('name')] = e.prop('checked')
      result

    self.submit = (event) ->
      event.preventDefault()

      $.ajax(
        type: 'put'
        url: "/api/ses/#{self.opts.subEntryId}/media/#{self.opts.item.id}"
        data: JSON.stringify(medium: form_data())
        success: (data) ->
          console.log data
          self.errors = undefined
          self.opts.modal.trigger 'close'
          wApp.bus.trigger 'pb-load-data'
        error: (request) ->
          data = JSON.parse(request.response)
          console.log data
          self.errors = data.errors
        complete: ->
          self.update()
      )

    self.reset = (event) ->
      self.opts.modal.trigger 'close'

  </script>

</pb-file-editor>