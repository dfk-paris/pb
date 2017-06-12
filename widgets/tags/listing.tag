<pb-listing>

  <virtual if={data}>

    <pb-search-form handler={searchHandler} />

    <pb-pagination
      total={data.total}
      per-page={data.per_page}
      page={data.page}
    />

    <div each={me in data.items} class="pb-main-entry">
      <em>Nr. {me.sequence}</em>
      <div><strong>{me.title}</strong></div>

      <virtual if={me.sub_entries.length == 1}>
        <em>{me.sub_entries[0].creator}</em>
        <div>{city_date(me.sub_entries[0])}</div>
        <pb-text-value label="Bezeichnet" value={me.sub_entries[0].markings} />
        <div class="text-value" if={dimensions(me.sub_entries[0])}>
          <p>
            {me.sub_entries[0].material}<br />
            {dimensions(me.sub_entries[0])}
          </p>
        </div>
        <pb-text-value
          label="Restaurierungen"
          value={me.sub_entries[0].restaurations}
        />
        <div class="text-value">
          <em>Standort</em>
          <p><pb-location id="{me.location}" /></p>
        </div>
        <pb-text-value
          label="Historische Nachweise"
          value={me.historical_evidence}
        />
        <pb-string-value
          label="Inv-Nr."
          value={me.sub_entries[0].inventory_ids.join('; ')}
        />
        <pb-text-value label="Literatur" value={me.literature} />
        <pb-text-value label="Herkunft" value={me.provenience} />
        <pb-text-value label="Beschreibung" value={me.description} />
        <pb-text-value label="Würdigung" value={me.appreciation} />
      </virtual>

      <virtual if={me.sub_entries.length > 1}>
        <div each={se in me.sub_entries} class="pb-sub-entry">
          <hr width="50%" />

          <em>Nr. {se.sequence}</em>
          <div><strong>{se.title}</strong></div>
          <em>{se.creator}</em>
          <div>{city_date(se)}</div>
          <pb-text-value label="Bezeichnet" value={se.markings} />
            <div class="text-value" if={dimensions(me.sub_entries[0])}>
            <p>
              {me.sub_entries[0].material}<br />
              {dimensions(me.sub_entries[0])}
            </p>
          </div>
        </div>

        <hr width="50%" />

        <div class="text-value">
          <em>Standort</em>
          <p><pb-location id="{me.location}" /></p>
        </div>
        <pb-text-value
          label="Historische Nachweise"
          value={me.historical_evidence}
        />
        <pb-text-value label="Literatur" value={me.literature} />
        <pb-text-value label="Herkunft" value={me.provenience} />
        <pb-text-value label="Beschreibung" value={me.description} />
        <pb-text-value label="Würdigung" value={me.appreciation} />
      </virtual>

      <hr />
    </div>
  </virtual>

  <script type="text/coffee">
    tag = this

    tag.on 'mount', ->
      wApp.bus.on 'routing:query', fetch

    tag.on 'unmount', ->
      wApp.bus.off 'routing:query', fetch

    tag.searchHandler = (data) -> fetch(data)

    fetch = (data = {}) ->
      Zepto.extend(data,
        per_page: 10
        page: wApp.routing.query()['page'] || 1
      )

      Zepto.ajax(
        type: 'get'
        url: '/api/mes'
        data: data
        success: (data) ->
          tag.data = data
          tag.update()
      )

    tag.city_date = (se) ->
      [se.location, se.dating].filter((e) -> !!e).join(', ')

    tag.dimensions = (se) ->
      fields = [
        se.height_with_socket, se.width_with_socket, se.depth_with_socket
        se.height, se.width, se.depth
      ]
      fields = fields.filter (e) -> !!e
      fields.join(', ')

    tag.apiUrl = -> wAppApiUrl

  </script>

</pb-listing>