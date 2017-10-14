<pb-input>

  <label>
    {opts.label}
    <input
      type={opts.type || 'text'}
      name={opts.name}
      class="u-full-width"
      placeholder={opts.placeholder || opts.label}
      riot-value={value_from_parent()}
      checked={checked()}
      autofocus={opts.autofocus}
    />
  </label>
  <ul class="pb-errors">
    <li each={e in opts.errors}>{e}</li>
  </ul>

  <script type="text/coffee">
    self = this

    self.value = ->
      if self.opts.type == 'checkbox'
        Zepto(self.root).find('input').prop('checked')
      else
        Zepto(self.root).find('input').val()
    self.value_from_parent = ->
      if self.opts.type == 'checkbox' then 1 else self.opts.riotValue
    self.checked = ->
      # console.log self.opts
      self.opts.type == 'checkbox' && self.opts.riotValue
  </script>

</pb-input>