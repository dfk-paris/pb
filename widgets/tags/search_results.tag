<pb-search-results>

  <virtual if={data}>
    <pb-pagination
      total={data.total}
      per-page={data.per_page}
      page={data.page}
    />

    <div each={me in data.items} class="pb-list-entry" onclick={openEntry}>
      <div class="pb-frame">
        <pb-icon which="right" />

        <div class="pb-item">
          <div
            class="pb-id"
            no-skype={me.sequence}
            x-ms-format-detection="none"
          ></div>
          <div class="pb-title">{me.title}</div>

          <virtual if={me.sub_entries.length == 1}>
            <div class="pb-creator">{me.sub_entries[0].creator}</div>
          </virtual>

          <pb-text-value value={me.description} />

          Letzte Änderung vom <w-timestamp value={me.updated_at} format="%d.%m.%Y" />
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
      highlighting()

    tag.openEntry = (event) ->
      wApp.bus.trigger 'modal', 'pb-main-entry', {me: event.item.me}

    noSkype = ->
      tpl = '<span style="display:none;">_</span>-'
      for e in Zepto(tag.root).find('[no-skype]')
        e = Zepto(e)
        e.html('Nr. ' + e.attr('no-skype').replace('-', tpl))

    hl = (match) ->
      "<mark>#{match}</mark>"

    highlighting = ->
      elements = Zepto(tag.root).find('.pb-title, .pb-creator, pb-text-value p')
      terms = []
      for n in ['terms', 'title', 'location', 'creator', 'inventory']
        if paramValue = wApp.routing.query()[n]
          terms = terms.concat(paramValue.split(/\s+/))
      for e in elements
        for t in terms
          e = Zepto(e)
          e.html e.html().replace(new RegExp(t, 'gi'), hl)


    fetch = (data = {}) ->
      params = {
        per_page: 10
        page: wApp.routing.query()['page'] || 1
        terms: wApp.routing.query()['terms']
        title: wApp.routing.query()['title']
        location: wApp.routing.query()['location']
        creator: wApp.routing.query()['creator']
        inventory: wApp.routing.query()['inventory']
      }

      doFetch = (params['page'] != 1 && params['page'] != '1') ||
                params['terms'] ||
                params['title'] ||
                params['location'] ||
                params['creator'] ||
                params['inventory']

      if !!doFetch
        Zepto.ajax(
          type: 'get'
          url: '/api/mes'
          data: params
          success: (data) ->
            tag.data = data
            tag.update()
        )
      else
        tag.data = undefined
        tag.update()

  </script>

</pb-search-results>