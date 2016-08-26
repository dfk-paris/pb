<pb-badge-list>
  <span class="outer" each={v in opts.values}>
    <small class="inner {'highlight': highlighted(v)}">{v}</small>
  </span>

  <style type="text/scss">
    @import "widgets/styles/vars.scss";

    pb-badge-list {
      & > .outer {
        padding-right: 0.3rem;
        position: relative;
        top: -2px;

        & > .inner {
          background-color: $gray;
          padding: 0.4rem;
          border-radius: 0.3rem;
          font-size: 1rem;

          &.highlight {
            background-color: $color-primary-1;
          }
        }
      }
    }
  </style>

  <script type="text/coffee">
    self = this

    self.highlighted = (v) ->
      self.opts.highlight &&
      v.toLowerCase().indexOf(self.opts.highlight.toLowerCase()) != -1
  </script>

</pb-badge-list>