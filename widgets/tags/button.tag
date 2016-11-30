<pb-button>

  <a href={opts.href} onclick={click}>
    <i class="fa fa-{opts.icon}"></i>
    {opts.label}
  </a>

  <script type="text/coffee">
    self = this

    self.click = (event) ->
      if self.opts.onclick
        false
      else
        true
  </script>

</pb-button>