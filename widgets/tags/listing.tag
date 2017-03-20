<pb-listing>

  <virtual if={data}>
    <div each={me in data.items} class="pb-main-entry">
      <em>Nr. {me.sequence}</em>
      <div><strong>{me.title}</strong></div>
      <pb-location id={me.location} />

      <pb-text-value label="Herkunft" value={me.provenience} />
      <pb-text-value label="Historische Nachweise" value={me.historical_evidence} />
      <pb-text-value label="Literatur" value={me.literature} />
      <pb-text-value label="Beschreibung" value={me.description} />
      <pb-text-value label="Würdigung" value={me.appreciation} />

      <div each={se in me.sub_entries} class="pb-sub-entry">
        <em>Nr. {se.sequence}</em>
        <div><strong>{se.title}</strong></div>
        <span>{creator_city_date(se)}</span>

        <pb-string-value label="Inv-Nr." value={se.inventory_ids.join('; ')} />
        <pb-string-value label="Markierungen" value={se.markings} />
        <pb-string-value label="Material" value={se.material} />
        <pb-text-value label="Maße" value={dimensions(se)} />
        <pb-string-value label="Gewicht" value={se.weight} />
        <pb-string-value label="Durchmesser" value={se.diameter} />
        <pb-text-value label="Restaurierungen" value={se.restaurations} />

        <div class="pb-media-grid" if={se.media.length > 0} >
          <div class="medium" each={medium in se.media} if={medium.publish}>
            <pb-image-viewer url="{apiUrl()}{medium.urls.normal}" />
            <div class="caption">
              {parent.se.sequence}{medium.caption ? ': ' : ''}
              <em>{medium.caption}</em>
            </div>
          </div>
          <div class="pb-clearfix"></div>
        </div>
      </div>

      <hr />
    </div>
  </virtual>

  <script type="text/coffee">
    self = this

    self.on 'mount', -> fetch()

    fetch = ->
      Zepto.ajax(
        type: 'get'
        url: '/api/mes'
        data: {per_page: 'all'}
        success: (data) ->
          self.data = data
          self.update()
      )

    self.creator_city_date = (se) ->
      [se.creator, se.location, se.date].filter((e) -> !!e).join(', ')

    self.dimensions = (se) ->
      fields = [
        se.height_with_socket, se.width_with_socket, se.depth_with_socket
        se.height, se.width, se.depth
      ]
      fields = fields.filter (e) -> !!e
      fields.join(', ')

    self.apiUrl = -> wAppApiUrl

  </script>

</pb-listing>