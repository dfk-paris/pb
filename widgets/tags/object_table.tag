<pb-object-table>

  <h1>Objekte</h1>

  <form>
    <div class="row">
      <div class="one-third column">
        <input
          class="u-full-width"
          type="text"
          name="terms"
          placeholder="Search everywhere"
        />
      </div>
      <div class="one-third column">
        <a onclick={toggle_criteria}>more …</a>
      </div>
    </div>

    <div class="criteria" if={criteria_visible}>
      <div class="row">
        <div class="one-third column">
          <input
            class="u-full-width"
            type="text"
            name="account_number"
            placeholder="Konto-Nr"
          />
        </div>
        <div class="one-third column">
          <input
            class="u-full-width"
            type="text"
            name="inventory"
            placeholder="Inventarbezeichnung"
          />
        </div>
      </div>

      <div class="row">
        <div class="one-third column">
          <input
            class="u-full-width"
            type="text"
            name="name"
            placeholder="Objektbezeichnung"
          />
        </div>
        <div class="one-third column">
          <input
            class="u-full-width"
            type="text"
            name="location"
            placeholder="Aufstellungsort"
          />
        </div>
        <div class="one-third column">
          <pb-people-autocomplete />
        </div>
      </div>
    </div>

    <hr />
  </form>

  <div class="pagination u-text-right">
    <i class="fa fa-chevron-circle-left"></i> |
    <i class="fa fa-chevron-circle-right"></i>
  </div>

  <table class="u-full-width">
    <thead>
      <tr>
        <th></th>
        <th>Objektbezeichnung</th>
        <th>Aufstellungsort</th>
        <th>Hersteller / Künstler</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <tr each={o in objects}>
        <td>
          <img class="pb-thumbnail" src={o.url} />
        </td>
        <td>{o.name}</td>
        <td>{o.location}</td>
        <td>{o.people}</td>
        <td class="buttons">
          <i class="fa fa-edit"></i>
          <i class="fa fa-remove"></i>
        </td>
      </tr>
    </tbody>
  </table>

  <script type="text/coffee">
    self = this

    self.toggle_criteria = (event) ->
      event.preventDefault()
      self.criteria_visible = !self.criteria_visible

    self.on 'mount', ->
      $.ajax(
        type: 'get'
        url: 'sample-data/data/objects.json'
        success: (data) ->
          self.objects = data
          self.update()
      )
  </script>

</pb-object-table>