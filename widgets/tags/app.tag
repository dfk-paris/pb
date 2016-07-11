<pb-app>

  <div class="container navigation">
    <div class="u-text-right">
      <a href="#/list">Liste</a> |
      <a href="#/editor">Eingabe</a>
    </div>

    <div class="pb-content" />
  </div>
  
  <style type="text/scss">
    @import "widgets/vars.scss";

    body {
      padding-bottom: 10rem;
    }

    a {
      cursor: pointer;
    }

    label {
      input, textarea, select {
        font-weight: normal;
      }

      textarea {
        min-height: 15rem;
        resize: none;
      }
    }

    .u-text-right {
      text-align: right;
    }

    .u-text-left {
      text-align: left; 
    }

    .u-text-center {
      text-align: center;
    }

    .pb-thumbnail {
      max-width: 8rem;
      max-height: 8rem;
    }

    .dropzone {
      text-align: center;
      vertical-align: middle;
      border: 3px dashed gray;
      color: gray;
      font-size: 3rem;
    }

    .navigation {
      margin-top: 2rem;
    }

    .buttons {
      white-space: nowrap;

      i {
        color: white;
        background-color: $blue;
        padding: 0.2rem;
        border-radius: 0.3rem;
      }
    }
  </style>

  <script type="text/coffee">
    Dropzone.autoDiscover = false
    
    $.extend $.ajaxSettings, {
      dataType: 'json'
      contentType: 'application/json'
    }

    self = this
    self.routing = {
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
    self.bus = riot.observable()
    window.pb = self
    

    self.on 'mount', ->
      self.routing.route = riot.route.create()
      self.routing.route '..', ->
        if document.location.href != self.routing.href
          self.routing.parts_cache = null
          self.routing.href = document.location.href
          pb.bus.trigger 'routing', self.routing.parts()
      riot.route.start(true)

    self.bus.on 'routing', (parts) ->
      console.log parts
      opts = {}
      tag = switch parts['hash_path']
        when '/list' then 'pb-object-table'
        when '/editor'
          opts['id'] = parts['hash_query'].id
          'pb-object-editor'
        else
          'pb-welcome'

      riot.mount $('.pb-content')[0], tag, opts
  </script>

</pb-app>