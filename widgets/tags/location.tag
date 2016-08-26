<pb-location>

  <span>{label()}</span>

  <script type="text/coffee">
    self = this

    self.label = ->
      (wApp.data.locations || {})[self.opts.id]

  </script>

</pb-location>