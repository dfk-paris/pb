<w-modal show={active}>

  <div class="receiver" ref="receiver"></div>

  <script type="text/coffee">
    tag = this
    tag.active = false
    tag.mountedTag = null

    tag.on 'mount', ->
      # wApp.bus.on 'routing:query', fromUrl
      Zepto(document).on 'keydown', closeOnEscape
      Zepto(tag.root).on 'click', closeOnBackClick
      # Zepto(window).on 'resize', fixHeight
      wApp.bus.on 'modal', launch
      wApp.bus.on 'close-modal', close
      # fixHeight()

    tag.on 'unmount', ->
      wApp.bus.off 'close-modal', close
      wApp.bus.off 'modal', launch
      # Zepto(window).off 'resize', fixHeight
      Zepto(document).off 'keydown', closeOnEscape
      Zepto(tag.root).off 'click', closeOnBackClick
      wApp.bus.off 'routing:query', fromUrl

    # tag.on 'close', ->

    launch = (tagName, opts = {}) ->
      # console.log 'modal', tagName, opts
      opts.modal = tagName
      opts.close = close
      tag.mountedTag = riot.mount(tag.refs.receiver, tagName, opts)[0]
      tag.active = true
      tag.update()

    unlaunch = ->
      if tag.active
        tag.active = false
        tag.triggeredByUrl = false
        tag.mountedTag.unmount(true)
        tag.update()

    close = ->
      if tag.triggeredByUrl
        removeFromUrl()
      else
        unlaunch()

    closeOnEscape = (event) ->
      if tag.active && event.key == 'Escape'
        close()

    closeOnBackClick = (event) ->
      if tag.active && event.target == tag.root
        close()

    # fixHeight = ->
    #   new_height = Math.max($(window).height() - 100, 500)
    #   Zepto(tag.root).find('.receiver').css 'height', new_height

    fromUrl = ->
      data = wApp.routing.packed()

      if data.modal
        tag.triggeredByUrl = true
        launch data.tag, data
      else
        unlaunch()

    removeFromUrl = ->
      wApp.routing.packed modal: null, tag: null, id: null, src: null

  </script>

</w-modal>