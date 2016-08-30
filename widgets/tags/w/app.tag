<w-app>

  <div class="container">
    <div class="pb-content" />
  </div>

  <w-modal />
  <w-messaging />

  <style type="text/scss">
    @import "widgets/styles/vars.scss";
  </style>

  <script type="text/coffee">
    Dropzone.autoDiscover = false
    
    $.extend $.ajaxSettings, {
      dataType: 'json'
      contentType: 'application/json'
    }

    $(document).on 'ajaxComplete', (event, request, options) ->
      try
        data = JSON.parse(request.response)
        # console.log data
        if data.message
          type = if request.status >= 200 && request.status < 300 then 'notice' else 'error'
          self.bus.trigger 'message', type, data.message
      catch e
        console.log e

    self = this
    self.routing = {
      query: (params) ->
        if params
          result = {}
          $.extend(result, self.routing.query(), params)
          qs = []
          for k, v of result
            if result[k] != null && result[k] != ''
              qs.push "#{k}=#{v}"
          riot.route "#{self.routing.path()}?#{qs.join '&'}"
        else
          self.routing.parts()['hash_query'] || {}
      path: (new_path) ->
        if new_path
          riot.route new_path
        else
          self.routing.parts()['hash_path']
      parts: ->
        unless self.routing.parts_cache
          h = document.location.href
          cs = h.match(/^(https?):\/\/([^\/]+)([^?#]+)?(?:\?([^#]+))?(?:#(.*))?$/)
          result = {
            href: h
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
    self.bus = riot.observable()
    self.data = {}
    self.utils = {
      shorten: (str, n = 15) ->
        if str && str.length > n
          str.substr(0, n - 1) + '&hellip;'
        else
          str
      in_groups_of: (per_row, array, dummy = null) ->
        result = []
        current = []
        for i in array
          if current.length == per_row
            result.push(current)
            current = []
          current.push(i)
        if current.length > 0
          if dummy
            while current.length < per_row
              current.push(dummy)
          result.push(current)
        result
      to_integer: (value) ->
        if $.isNumeric(value)
          parseInt(value)
        else
          value
    }
    window.wApp = self
    
    self.on 'mount', ->
      $.ajax(
        type: 'get'
        url: 'data/locations.json'
        success: (data) ->
          self.data.locations = {}
          for group in data
            for room in group.rooms
              self.data.locations[room.id] = room.name
          riot.update()
      )

      riot.route.base "#/"
      self.routing.route = riot.route.create()
      self.routing.route '..', ->
        old_parts = self.routing.parts()
        if document.location.href != old_parts['href']
          self.routing.parts_cache = null
          console.log self.routing.parts()
          wApp.bus.trigger 'routing:href', self.routing.parts()

          if old_parts['hash_path'] != self.routing.path()
            wApp.bus.trigger 'routing:path', self.routing.parts()
          else
            wApp.bus.trigger 'routing:query', self.routing.parts()
      riot.route.start(true)
      wApp.bus.trigger 'routing:path', self.routing.parts()

    self.bus.on 'routing:path', (parts) ->
      opts = {}
      tag = switch parts['hash_path']
        when '/mes/edit', '/mes/new'
          opts['id'] = parts['hash_query'].id
          opts.bla = "asdf"
          'pb-me-editor'
        when '/ses/edit', '/ses/new'
          opts['id'] = parts['hash_query'].id
          opts['main_entry_id'] = parts['hash_query'].main_entry_id
          'pb-se-editor'
        else
          'pb-mes-table'
      riot.mount $('.pb-content')[0], tag, opts
      window.scrollTo(0, 0)

  </script>

</w-app>