<pb-badge-list>
  <span class="outer" each={v in opts.values}>
    <small class="inner {'highlight': highlighted(v)}">{v}</small>
  </span>

  <script type="text/coffee">
    self = this

    self.highlighted = (v) ->
      self.opts.highlight &&
      v.toLowerCase().indexOf(self.opts.highlight.toLowerCase()) != -1
  </script>

</pb-badge-list>