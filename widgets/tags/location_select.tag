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
      Zepto(self.root).find('select').val(opts.riotValue)

      Zepto.ajax(
        type: 'get'
        url: '/api/locations'
        success: (data) ->
          self.data = data
          self.update()
      )

    self.is_selected = (location) ->
      location.id == opts.riotValue

    self.value = -> Zepto(self.root).find('select').val()
  </script>
</pb-location-select>
