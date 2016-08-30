<pb-input>

  <label>
    {opts.label}
    <input
      type={opts.type || 'text'}
      name={opts.name}
      class="u-full-width"
      placeholder={opts.placeholder || opts.label}
      value={value_from_parent()}
      checked={checked()}
    />
  </label>
  <ul class="pb-errors">
    <li each={e in opts.errors}>{e}</li>
  </ul>

  <script type="text/coffee">
    self = this

    self.value = ->
      if self.opts.type == 'checkbox'
        $(self.root).find('input').prop('checked')
      else
        $(self.root).find('input').val()
    self.value_from_parent = ->
      if self.opts.type == 'checkbox' then 1 else self.opts.value
    self.checked = ->
      self.opts.type == 'checkbox' && self.opts.value
  </script>

</pb-input>