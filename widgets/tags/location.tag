<pb-location>

  <span>{label()}</span>

  <script type="text/coffee">
    self = this

    self.label = ->
      (pb.data.locations || {})[self.opts.id]

  </script>

</pb-location>