<pb-string-value>

  <div class="string-value" if={opts.showIfEmpty || opts.riotValue}>
    <em>{opts.label}</em>:
    <pb-special-render
      value={opts.riotValue}
      tagged-text={true}
    />
    {opts.unit}
  </div>

</pb-string-value>