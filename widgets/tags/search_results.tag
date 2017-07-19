<pb-search-results>

  <virtual if={data && data.total > 0}>

    <pb-pagination
      total={data.total}
      per-page={data.per_page}
      page={data.page}
    />

    <div each={me in data.items} class="pb-list-entry" onclick={openEntry}>
      <em>Nr. {me.sequence}</em>
      <div><strong>{me.title}</strong></div>

      <virtual if={me.sub_entries.length == 1}>
        <em>{me.sub_entries[0].creator}</em>
      </virtual>

      <pb-text-value value={me.description} />
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
      if tag.data && tag.data.total > 0
        elements.animate({opacity: 0}, {
          complete: -> elements.hide()  
        })
      else
        elements.css 'opacity', 0
        elements.show()
        elements.animate({opacity: 1})

    tag.openEntry = (event) ->
      wApp.bus.trigger 'modal', 'pb-main-entry', {me: event.item.me}

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