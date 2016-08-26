<pb-input>

  <label>
    {opts.label}
    <input
      type={opts.type || 'text'}
      name={opts.name}
      class="u-full-width"
      placeholder={opts.placeholder || opts.label}
      value={opts.value}
    />
  </label>
  <ul class="pb-errors">
    <li each={e in opts.errors}>{e}</li>
  </ul>

  <script type="text/coffee">
    self = this

    self.value = -> $(self.root).find('input').val()
  </script>

</pb-input>