<pb-search-results>

  <virtual if={data}>
    <pb-pagination
      total={data.total}
      per-page={data.per_page}
      page={data.page}
      any-selected={anySelected}
      open-selection={openSelectedEntries}
      clear-selection={clearSelection}
    />

    <div each={me, i in data.items} class="pb-list-entry" onclick={openEntry}>
      <div class="pb-frame">
        <pb-icon which="right" />

        <div class="pb-item">
          <input
            type="checkbox"
            onchange={toggleSelection}
            onclick={propStop}
            checked={isSelected(me.id)}
          />

          <div
            class="pb-id"
            no-skype={me.sequence}
            x-ms-format-detection="none"
          ></div>
          
          <div class="pb-title">
            <pb-special-render
              value={me.title}
              highlight-fields={['title']}
              tagged-text={true}
            />
          </div>

          <virtual if={me.sub_entries.length == 1}>
            <div class="pb-creator">
              <pb-special-render
                value={me.sub_entries[0].creator}
                highlight-fields={['terms', 'people', 'inventory']}
                tagged-text={true}
              />
            </div>
          </virtual>

          <img
            if={firstImageSrc(me)}
            class="pb-image-teaser"
            riot-src={firstImageSrc(me)}
          />

          <pb-text-value
            value={me.description}
            highlight-fields={['terms', 'people', 'inventory']}
            tagged-text={true}
          />

          <div class="pb-clearfix"></div>

          <div class="pb-item-footer">
            Letzte Änderung vom <w-timestamp value={me.updated_at} format="%d.%m.%Y" />,
            Autoren: Jörg Ebeling, Ulrich Leben
          </div>
        </div>

        <div class="pb-clearfix"></div>
      </div>
    </div>
  </virtual>

  <script type="text/coffee">
    tag = this

    tag.on 'mount', ->
      wApp.bus.on 'routing:query', fetch

    tag.on 'unmount', ->
      wApp.bus.off 'routing:query', fetch

    tag.on 'updated', ->
      elements = Zepto('.pb-hide-on-results')
      if tag.data
        elements.animate({opacity: 0}, {
          complete: -> elements.hide()  
        })
      else
        elements.css 'opacity', 0
        elements.show()
        elements.animate({opacity: 1})

      noSkype()

    tag.toggleSelection = (event) ->
      selection = Lockr.get('selected-results', [])
      selected = Zepto(event.target).prop('checked')
      id = event.item.me.id

      if selected
        selection.push id
      else
        i = selection.indexOf(id)
        selection.splice(i, 1)

      Lockr.set('selected-results', selection)
      tag.update()

    tag.clearSelection = (event) ->
      Lockr.set('selected-results')
      tag.update()

    tag.selectAll = (event) ->
      selection = (me.id for me in tag.data.items)
      Lockr.set('selected-results', selection)
      tag.update()

    tag.isSelected = (id) ->
      i = Lockr.get('selected-results', []).indexOf(id)
      return i != -1

    tag.anySelected = (event) ->
      return Lockr.get('selected-results', []).length > 0

    tag.propStop = (event) -> event.stopPropagation()

    tag.openSelectedEntries = ->
      selection = Lockr.get('selected-results', [])
      wApp.bus.trigger 'modal', 'pb-multi-main-entry', {mes: selection}

    tag.openEntry = (event) ->
      wApp.routing.query modal: true, tag: 'pb-main-entry', id: event.item.me.id

    tag.firstImageSrc = (me) ->
      for se in me.sub_entries
        for medium in se.media
          if medium.publish
            return wAppApiUrl + medium.urls.normal
      null

    noSkype = ->
      tpl = '<span style="display:none;">_</span>-'
      for e in Zepto(tag.root).find('[no-skype]')
        e = Zepto(e)
        e.html('Nr. ' + e.attr('no-skype').replace('-', tpl))

    fetch = (data = {}) ->
      params = {
        per_page: wApp.routing.query()['per_page'] || 10
        page: wApp.routing.query()['page'] || 1
        terms: wApp.routing.query()['terms']
        title: wApp.routing.query()['title']
        location: wApp.routing.query()['location']
        people: wApp.routing.query()['people']
        inventory: wApp.routing.query()['inventory']
      }

      doFetch = (params['page'] != 1 && params['page'] != '1') ||
                (params['per_page'] != 10 && params['page'] != '10') ||
                params['terms'] ||
                params['title'] ||
                params['location'] ||
                params['people'] ||
                params['inventory']

      if !!doFetch
        Zepto.ajax(
          type: 'get'
          url: '/api/mes'
          data: params
          success: (data) ->
            tag.data = data
            tag.selected = []
            tag.update()
        )
      else
        tag.data = undefined
        tag.update()

  </script>

</pb-search-results>