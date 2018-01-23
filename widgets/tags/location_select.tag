<pb-location-select>

  <label>
    {opts.label}
    <select
      name={opts.name}
      class="u-full-width"
      autocomplete="off"
    >
      <option value="0" if={opts.prompt}>Standort</option>
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

    tag.on 'mount', ->
      if tag.opts.riotValue
        Zepto(tag.root).find('select').val(tag.opts.riotValue)
      else
        Zepto(tag.root).find('select').val('0')

    tag.locations = ->
      if !tag.locs && wApp.data.locationList
        tag.locs = wApp.data.locationList

        if tag.opts.onlyInUse
          for level in tag.locs
            level['rooms'] = (r for r in level['rooms'] when r.in_use)

      return tag.locs

    tag.is_selected = (location) ->
      location.id == tag.opts.riotValue

    tag.noValue = -> !tag.opts.riotValue

    tag.value = -> Zepto(tag.root).find('select').val()
  </script>
</pb-location-select>
