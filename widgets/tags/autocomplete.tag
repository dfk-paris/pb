<pb-autocomplete>

  <pb-input
    label={opts.label}
    name={opts.name}
    placeholder={opts.placeholder || opts.label}
    value={opts.value}
  />

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      self.ac = new autoComplete(
        selector: $(self.root).find('input')[0]
        minChars: 2
        source: (term, suggest) ->
          $.ajax(
            type: 'get'
            url: "api/ses/autocomplete"
            data: {
              column: opts.name
              term: term
            }
            dataType: 'json'
            success: (data) -> 
              suggest(data)
          )
      )

    self.value = -> self.tags['pb-input'].value()
  </script>
</pb-autocomplete>