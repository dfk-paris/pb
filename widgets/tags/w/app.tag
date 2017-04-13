<w-app>

  <div class="container">
    <div class="pb-content" />
  </div>

  <w-modal />
  <w-messaging />
  <w-styles />

  <script type="text/coffee">
    tag = this

    tag.on 'mount', ->
      Zepto(document).on 'click', 'img[src-large]', enlargeImage

    tag.on 'unmount', ->
      Zepto(document).off 'click', 'img[src-large]', enlargeImage

    enlargeImage = (event) ->
      url = Zepto(event.target).attr('src-large')
      wApp.bus.trigger 'modal', 'pb-image-viewer', url: url
    
    wApp.bus.on 'routing:path', (parts) ->
      opts = {}
      tagName = switch parts['hash_path']
        when '/mes/form'
          opts['id'] = parts['hash_query'].id
          opts.bla = "asdf"
          'pb-me-editor'
        when '/ses/form'
          opts['id'] = parts['hash_query'].id
          opts['main_entry_id'] = parts['hash_query'].main_entry_id
          'pb-se-editor'
        else
          'pb-mes-table'

      mountPage(tagName, opts)

    mountPage = (tagName, opts) ->
      if tag.mountedTag
        tag.mountedTag.unmount(true)
        
      tag.mountedTag = riot.mount(Zepto('.pb-content')[0], tagName, opts)[0]
      window.scrollTo(0, 0)

  </script>

</w-app>