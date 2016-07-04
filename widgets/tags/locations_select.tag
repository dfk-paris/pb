<pb-locations-select>

  <select
    class="u-full-width"
    name="location"
    id="pb_form_object_location"
    onchange={parent.selection_changed}
  >
    <optgroup each={group in location_groups} label={group.name}>
      <option each={location in group.options}>{location}</option>
    </optgroup>
  </select>

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      $.ajax(
        type: 'get'
        url: 'sample-data/data/locations.json'
        success: (data) ->
          self.location_groups = data
          self.parent.selection_changed()
          self.update()
      )

    self.french_value = -> $(self.root).find('select').val().split('/')[1]
  </script>
</pb-locations-select>
