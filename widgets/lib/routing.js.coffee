wApp.routing = {
  query: (params) ->
    if params
      result = {}
      Zepto.extend(result, wApp.routing.query(), params)
      qs = []
      for k, v of result
        if result[k] != null && result[k] != ''
          qs.push "#{k}=#{v}"

      base = wApp.routing.path() || ''
      route "#{base}?#{qs.join '&'}"
    else
      wApp.routing.parts()['hash_query'] || {}
  path: (new_path) ->
    if new_path
      route new_path
    else
      wApp.routing.parts()['hash_path']
  parts: ->
    unless wApp.routing.parts_cache
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
      wApp.routing.parts_cache = result
    wApp.routing.parts_cache
  setup: ->
    wApp.routing.route = route.create()
    route.base "#/"
    
    wApp.routing.route ->
      # console.log 'routing', arguments

      oldParts = wApp.routing.parts_cache || {}
      wApp.routing.parts_cache = null

      if wApp.routing.parts()['href'] != oldParts['href']
        # console.log 'routing','href changed'
        wApp.bus.trigger 'routing:href', wApp.routing.parts()

        if oldParts['hash_path'] != wApp.routing.path()
          # console.log 'routing','path changed'
          wApp.bus.trigger 'routing:path', wApp.routing.parts()
        
        if oldParts['hash'] != wApp.routing.parts()['hash']
          # console.log 'routing','query changed'
          wApp.bus.trigger 'routing:query', wApp.routing.parts()

    route.start(true)
    wApp.routing.parts() # warm cache
    wApp.bus.trigger 'routing:path', wApp.routing.parts()
    wApp.bus.trigger 'routing:query', wApp.routing.parts()
}
