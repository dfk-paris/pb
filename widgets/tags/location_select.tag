<pb-location-select>

  <label>
    {opts.label}
    <select
      name={opts.name}
      class="u-full-width"
    >
      <option value="0" if={opts.prompt}>.. bitte auswählen</option>
      <optgroup each={group in locations()} label={group.name}>
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
    tag = this
    window.t = tag

    tag.on 'mount', ->
      Zepto(tag.root).find('select').val(opts.riotValue)

    tag.locations = -> wApp.data.locationList

    tag.is_selected = (location) ->
      location.id == opts.riotValue

    tag.value = -> Zepto(tag.root).find('select').val()
  </script>
</pb-location-select>
