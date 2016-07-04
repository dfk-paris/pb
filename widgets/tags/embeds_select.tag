<pb-embeds-select>

  <select
    id="pb_form_object_embeds"
    class="u-full-width"
    name="embeds"
    onchange={parent.selection_changed}
  >
    <option each={embed in embeds}>{embed}</option>    
  </select>

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      $.ajax(
        type: 'get'
        url: 'sample-data/data/embeds.json'
        dataType: 'json'
        success: (data) ->
          self.embeds = data
          self.parent.selection_changed()
          self.update()
      )

    self.french_value = -> $(self.root).find('select').val().split('/')[1]
  </script>
</pb-embeds-select>