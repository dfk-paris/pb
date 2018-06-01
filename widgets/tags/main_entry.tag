<pb-main-entry>

  <div if={opts.me}>

    <div class="w-text-right no-print" if={!opts.omitControls}>
      <button onclick={newSearch}>neue Suche</button>
      <button onclick={print}>drucken</button>
      <button onclick={close}>schließen</button>
      <button onclick={toggleExpand}>Abbildungen vergrößern/verkleinern</button>
    </div>

    <hr class="no-print" if={!opts.omitControls} />

    <em>Nr. {opts.me.sequence}</em>
    <div><strong>
      <pb-special-render
        value={opts.me.title}
        tagged-text={true}
      />
    </strong></div>

    <virtual if={opts.me.sub_entries.length == 1}>
      <em>
        <pb-person name={opts.me.sub_entries[0].creator} />
      </em>
      <div>{city_date(opts.me.sub_entries[0])}</div>
      <pb-string-value
        label="Inv. Nr. (Anlage-Nr./Equip.-Nr.)"
        value={humanIds(opts.me.sub_entries[0].inventory_ids)}
        class="block-style"
      />
      <pb-text-value
        label="Bezeichnet" value={opts.me.sub_entries[0].markings}
        tagged-text={true}
      />
      <div class="text-value" if={dimensions(opts.me.sub_entries[0])}>
        <p>
          {opts.me.sub_entries[0].material}<br />
          {dimensions(opts.me.sub_entries[0])}
        </p>
      </div>
      <pb-text-value
        label="Restaurierungen"
        value={opts.me.sub_entries[0].restaurations}
        tagged-text={true}
      />
      <div class="text-value">
        <em>Standort</em>
        <p><pb-location id="{opts.me.location}" /></p>
      </div>
      <pb-text-value
        label="Historische Nachweise"
        value={opts.me.historical_evidence}
        tagged-text={true}
      />
      <pb-text-value
        label="Literatur"
        value={opts.me.literature}
        tagged-text={true}
      />
      <pb-text-value
        label="Herkunft"
        value={opts.me.provenience}
        tagged-text={true}
      />
      <pb-text-value
        label="Beschreibung"
        value={opts.me.description}
        tagged-text={true}
      />
      <pb-text-value
        label="Würdigung"
        value={opts.me.appreciation}
        tagged-text={true}
      />

      <pb-media-grid se={opts.me.sub_entries[0]} expand={expand} />
    </virtual>

    <virtual if={opts.me.sub_entries.length > 1}>
      <virtual if={singleCreator()}>
        <div><em>
          <pb-person name={singleCreator()} />
        </em></div>
      </virtual>
      <virtual if={singleCityDate()}>
        <div><em>{singleCityDate()}</em></div>
      </virtual>

      <div class="text-value location">
        <em>Standort</em>
        <p><pb-location id="{opts.me.location}" /></p>
      </div>
      <pb-text-value
        label="Historische Nachweise"
        value={opts.me.historical_evidence}
        tagged-text={true}
      />
      <pb-text-value
        label="Literatur"
        value={opts.me.literature}
        tagged-text={true}
      />
      <pb-text-value
        label="Herkunft"
        value={opts.me.provenience}
        tagged-text={true}
      />
      <pb-text-value
        label="Beschreibung"
        value={opts.me.description}
        tagged-text={true}
      />
      <pb-text-value
        label="Würdigung"
        value={opts.me.appreciation}
        tagged-text={true}
      />

      <div each={se in opts.me.sub_entries} class="pb-sub-entry">
        <hr width="50%" />

        <em>Nr. {se.sequence}</em>
        <div><strong>
          <pb-special-render
            value={se.title}
            tagged-text={true}
          />
        </strong></div>
        <virtual if={!singleCreator()}>
          <div><em>
            <pb-person name={se.creator} />
          </em></div>
        </virtual>
        <virtual if={!singleCityDate()}>
          <div>{city_date(se)}</div>
        </virtual>
        <pb-string-value
          label="Inv. Nr. (Anlage-Nr./Equip.-Nr.)"
          value={humanIds(se.inventory_ids)}
          class="block-style"
        />
        <pb-text-value
          label="Bezeichnet"
          value={se.markings}
          tagged-text={true}
        />
        <div class="text-value" if={dimensions(se)}>
          <p>
            {se.material}<br />
            {dimensions(se)}
          </p>
        </div>
        <pb-text-value
          label="Restaurierungen"
          value={se.restaurations}
          tagged-text={true}
        />

        <pb-media-grid se={se} expand={expand} />
      </div>

    </virtual>

    <div class="u-text-right u-text-small pb-timestamp">
      Letzte Änderung vom
      <w-timestamp value={opts.me.updated_at} format="%d.%m.%Y" />,
      Autoren: Jörg Ebeling, Ulrich Leben
    </div>

    <div class="u-text-right u-text-small pb-timestamp">
      Zitierlink: 
      <a href={currentUrl()}>{currentUrl()}</a>, letzter Zugriff am
      {currentDate()}
    </div>
  </div>

  <script type="text/coffee">
    tag = this
    tag.expand = true

    tag.on 'mount', ->
      fetch() unless tag.opts.me

    tag.city_date = (se) ->
      [se.location, se.dating].filter((e) -> !!e).join(', ')

    tag.dimensions = (se) ->
      fields = []

      fields.push('Höhe: ' + se.height_with_socket) if !!se.height_with_socket
      fields.push('Breite: ' + se.width_with_socket) if !!se.width_with_socket
      fields.push('Tiefe: ' + se.depth_with_socket) if !!se.depth_with_socket
      op = fields.join(', ')

      fields = []
      fields.push('Höhe: ' + se.height) if !!se.height
      fields.push('Breite: ' + se.width) if !!se.width
      fields.push('Tiefe: ' + se.depth) if !!se.depth
      mp = fields.join(', ')

      fields = []
      fields.push('Gewicht: ' + se.weight) if !!se.weight
      fields.push('Durchmesser: ' + se.diameter) if !!se.diameter
      dia = fields.join('')

      result = [op, mp, dia].filter (e) -> e != ''
      result.join('; ')

    tag.newSearch = (event) ->
      tag.close()
      for form in Zepto('pb-search-form form')
        form.reset()
      wApp.routing.path('/')

    tag.print = (event) ->
      wApp.utils.printElement(tag.root);

    tag.close = (event) ->
      c() if c = tag.opts.close

    tag.toggleExpand = (event) ->
      tag.expand = !tag.expand
      tag.update()

    tag.humanIds = (ids) ->
      strs = for id in ids
        parts = id.split(/[\|\!]/)
        "#{parts[0] || 'n.v.'} (#{parts[1] || 'n.v.'}/#{parts[2] || 'n.v.'})"
      strs.join('; ')

    tag.singleCreator = ->
      ses = tag.opts.me.sub_entries
      previous = ses[0].creator
      for se in ses[1..-1]
        return false if previous != se.creator
      previous

    tag.singleCityDate = ->
      ses = tag.opts.me.sub_entries
      previous = tag.city_date(ses[0])
      for se in ses[1..-1]
        return false if previous != tag.city_date(se)
      previous

    fetch = ->
      $.ajax(
        url: "/api/mes/#{tag.opts.id}.json"
        accepts: 'application/json'
        success: (data) ->
          tag.opts.me = data
          tag.update()
      )

    tag.currentUrl = ->
      base = document.location.href.split('#')[0]
      "#{base}#/?modal=true&tag=pb-main-entry&id=#{tag.opts.id}"

    tag.currentDate = ->
      strftime("%-d.%-m.%Y", new Date())

  </script>

</pb-main-entry>