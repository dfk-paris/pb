<pb-location-select>

  <label>
    {opts.label}
    <select
      name={opts.name}
      class="u-full-width"
    >
      <option value="0" if={opts.prompt}>.. bitte auswählen</option>
      <optgroup each={group in data} label={group.name}>
        <option
          each={location in group.rooms}
          value={location.id}
          selected={is_selected(location)}
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
          self.data = data
          self.update()
      )

    self.is_selected = (location) ->
      location.id == opts.value

    self.value = -> $(self.root).find('select').val()
  </script>
</pb-location-select>
