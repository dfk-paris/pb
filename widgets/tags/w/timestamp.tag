<w-timestamp>
  <span>{formatted()}</span>

  <script type="text/coffee">
    tag = this

    tag.formatted = ->
      format = tag.opts.format || '%B %d, %Y %H:%M:%S'

      if tag.opts.riotValue
        ts = new Date(tag.opts.riotValue)
        strftime format, ts
      else
        null
  </script>
</w-timestamp>