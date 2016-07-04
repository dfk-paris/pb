<pb-people-autocomplete>

  <input
    id="pb_form_object_people"
    class="u-full-width"
    type="text"
    name="people"
    placeholder="Hersteller / Künstler"
  />

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      $.ajax(
        type: 'get'
        url: 'sample-data/data/people.json'
        dataType: 'json'
        success: (data) -> self.people = data
      )

      self.ac = new autoComplete(
        selector: $(self.root).find("input[name='people']")[0]
        minChars: 1
        source: (term, suggest) ->
          term = term.toLowerCase()
          matches = []
          for person in self.people
            if person.toLowerCase().indexOf(term) != -1
              matches.push person
          suggest(matches)
      )
  </script>
</pb-people-autocomplete>