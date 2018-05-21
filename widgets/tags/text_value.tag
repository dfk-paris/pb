<pb-text-value>

  <div class="text-value" if={opts.riotValue}>
    <em>{opts.label}</em>
    <p>
      <pb-special-render
        value={opts.riotValue}
        highlight-fields={opts.highlightFields}
        tagged-text={opts.taggedText}
      />
    </p>
  </div>

  <script type="text/javascript">
    var tag = this;
  </script>

</pb-text-value>