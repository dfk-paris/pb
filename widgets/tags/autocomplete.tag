<pb-autocomplete>

  <pb-input
    label={opts.label}
    name={opts.name}
    placeholder={opts.placeholder || opts.label}
    value={opts.riotValue}
    ref="input"
  />

  <script type="text/coffee">
    tag = this

    tag.on 'mount', ->
      tag.ac = new autoComplete(
        selector: Zepto(tag.root).find('input')[0]
        minChars: 2
        source: (term, suggest) ->
          Zepto.ajax(
            type: 'get'
            url: "/api/ses/autocomplete"
            data: {
              column: opts.name
              term: term
            }
            dataType: 'json'
            success: (data) -> 
              suggest(data)
          )
      )

    tag.value = -> tag.refs.input.value()
  </script>
</pb-autocomplete>