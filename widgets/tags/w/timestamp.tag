<w-timestamp>
  <span>{formatted()}</span>

  <script type="text/coffee">
    tag = this

    tag.formatted = ->
      if tag.opts.riotValue
        ts = new Date(tag.opts.riotValue)
        strftime '%B %d, %Y %H:%M:%S', ts
      else
        null
  </script>
</w-timestamp>