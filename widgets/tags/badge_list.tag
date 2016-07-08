<pb-badge-list>
  <span class="outer" each={v in opts.values}>
    <small class="inner">{v}</small>
  </span>

  <style type="text/scss">
    @import "widgets/vars.scss";

    pb-badge-list {
      & > .outer {
        padding-right: 0.3rem;

        & > .inner {
          background-color: $gray;
          padding: 0.4rem;
          border-radius: 0.3rem;
        }
      }
    }
  </style>
</pb-badge-list>