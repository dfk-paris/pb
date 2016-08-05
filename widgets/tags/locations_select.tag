<pb-locations-select>

  <label>
    {opts.label}
    <select
      name={opts.name}
      class="u-full-width"
    >
      <optgroup each={group in location_groups} label={group.name}>
        <option
          each={location in group.rooms}
          value={location.id}
          selected={location.id == opts.value}
        >
          {location.name}
        </option>
      </optgroup>
    </select>
  </label>

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      $(self.root).find('select').val(opts.value)

      $.ajax(
        type: 'get'
        url: '/data/locations.json'
        success: (data) ->
          self.location_groups = data
          self.parent.selection_changed()
          self.update()
      )

    self.french_value = -> $(self.root).find('select').val().split('/')[1]
  </script>
</pb-locations-select>
