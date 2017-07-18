<pb-main-entry>

  <em>Nr. {opts.me.sequence}</em>
  <div><strong>{opts.me.title}</strong></div>

  <virtual if={opts.me.sub_entries.length == 1}>
    <em>{opts.me.sub_entries[0].creator}</em>
    <div>{city_date(opts.me.sub_entries[0])}</div>
    <pb-text-value label="Bezeichnet" value={opts.me.sub_entries[0].markings} />
    <div class="text-value" if={dimensions(opts.me.sub_entries[0])}>
      <p>
        {opts.me.sub_entries[0].material}<br />
        {dimensions(opts.me.sub_entries[0])}
      </p>
    </div>
    <pb-text-value
      label="Restaurierungen"
      value={opts.me.sub_entries[0].restaurations}
    />
    <div class="text-value">
      <em>Standort</em>
      <p><pb-location id="{opts.me.location}" /></p>
    </div>
    <pb-text-value
      label="Historische Nachweise"
      value={opts.me.historical_evidence}
    />
    <pb-string-value
      label="Inv-Nr."
      value={opts.me.sub_entries[0].inventory_ids.join('; ')}
    />
    <pb-text-value label="Literatur" value={opts.me.literature} />
    <pb-text-value label="Herkunft" value={opts.me.provenience} />
    <pb-text-value label="Beschreibung" value={opts.me.description} />
    <pb-text-value label="Würdigung" value={opts.me.appreciation} />
  </virtual>

  <virtual if={opts.me.sub_entries.length > 1}>
    <div each={se in opts.me.sub_entries} class="pb-sub-entry">
      <hr width="50%" />

      <em>Nr. {se.sequence}</em>
      <div><strong>{se.title}</strong></div>
      <em>{se.creator}</em>
      <div>{city_date(se)}</div>
      <pb-text-value label="Bezeichnet" value={se.markings} />
        <div class="text-value" if={dimensions(opts.me.sub_entries[0])}>
        <p>
          {opts.me.sub_entries[0].material}<br />
          {dimensions(opts.me.sub_entries[0])}
        </p>
      </div>
    </div>

    <hr width="50%" />

    <div class="text-value">
      <em>Standort</em>
      <p><pb-location id="{opts.me.location}" /></p>
    </div>
    <pb-text-value
      label="Historische Nachweise"
      value={opts.me.historical_evidence}
    />
    <pb-text-value label="Literatur" value={opts.me.literature} />
    <pb-text-value label="Herkunft" value={opts.me.provenience} />
    <pb-text-value label="Beschreibung" value={opts.me.description} />
    <pb-text-value label="Würdigung" value={opts.me.appreciation} />
  </virtual>

  <script type="text/coffee">
    tag = this

    tag.city_date = (se) ->
      [se.location, se.dating].filter((e) -> !!e).join(', ')

    tag.dimensions = (se) ->
      fields = [
        se.height_with_socket, se.width_with_socket, se.depth_with_socket
        se.height, se.width, se.depth
      ]
      fields = fields.filter (e) -> !!e
      fields.join(', ')

  </script>

</pb-main-entry>