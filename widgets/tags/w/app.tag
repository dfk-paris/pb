<w-app>

  <!-- your html goes here -->
  
  <style type="text/scss">
    @import "widgets/styles/vars.scss";

    /* your rules go here*/
  </style>

  <script type="text/coffee">
    self = this
    self.bus = riot.observable()
    self.data = {}
    window.wApp = self

    # setting default ajax options
    $.extend $.ajaxSettings, {
      dataType: 'json'
      contentType: 'application/json'
    }

    # handle notice and error messages received through ajax requests
    $(document).on 'ajaxComplete', (event, request, options) ->
      try
        data = JSON.parse(request.response)
        console.log data
        if data.message
          type = if request.status >= 200 && request.status < 300 then 'notice' else 'error'
          self.bus.trigger 'message', type, data.message
      catch e
        console.log e

    # routing
    self.routing = {
      setup: ->
        riot.route.base "#/"
        self.routing.route = riot.route.create()
        self.routing.route '..', ->
          if document.location.href != self.routing.href
            self.routing.parts_cache = null
            self.routing.href = document.location.href
            wApp.bus.trigger 'routing', self.routing.parts()
        riot.route.start(true)
      query: -> self.routing.parts()['hash_query']
      path: -> self.routing.parts()['hash_path']
      parts: ->
        unless self.routing.parts_cache
          h = document.location.href
          cs = h.match(/^(https?):\/\/([^\/]+)([^?#]+)?(?:\?([^#]+))?(?:#(.*))?$/)
          result = {
            scheme: cs[1]
            host: cs[2]
            path: cs[3]
            query_string: cs[4]
            query: {}
            hash: cs[5]
            hash_query: {}
          }
          if result.query_string
            for pair in result.query_string.split('&')
              kv = pair.split('=')
              result.query[kv[0]] = kv[1]
          if result.hash
            result.hash_path = result.hash.split('?')[0]
            
            if hash_query_string = result.hash.split('?')[1]
              for pair in hash_query_string.split('&')
                kv = pair.split('=')
                result.hash_query[kv[0]] = kv[1]
          self.routing.parts_cache = result
        self.routing.parts_cache
    }
    
    self.on 'mount', ->
      self.routing.setup()

    self.bus.on 'routing', (parts) ->
      # your routing goes here, use the parts object to inspect the routing
      # context and mount tags with suitable opts on a target element, e.g.:

      # target = '.page-content'
      # opts = {}
      # tag = switch parts['hash_path']
      #   when '/articles/edit', '/articles/new'
      #     opts['id'] = parts['hash_query'].id
      #     'my-editor'
      #   else
      #     'welcome'
      # riot.mount $(target)[0], tag, opts

    self.bus.on 'message', (type, message) ->
      # implement custom user messaging here
      console.log type.toUpperCase(), message
  </script>

</w-app>