<w-app>

  <div class="container">
    <div class="pb-content" />
  </div>

  <w-modal />
  <w-messaging />
  <w-styles />

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      Zepto(document).on 'click', 'img[src-large]', (event) ->
        # console.log event.target
        url = Zepto(event.target).attr('src-large')
        wApp.bus.trigger 'modal', 'pb-image-viewer', url: url
      wApp.routing.setup()
    
    wApp.bus.on 'routing:path', (parts) ->
      opts = {}
      tag = switch parts['hash_path']
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
      riot.mount Zepto('.pb-content')[0], tag, opts
      window.scrollTo(0, 0)

  </script>

</w-app>