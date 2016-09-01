<pb-listing>

  <div each={me in data.items} class="pb-main-entry">
    {me.title}
  </div>

  <script type="text/coffee">
    self = this

    self.on 'mount', -> fetch()

    fetch = ->
      $.ajax(
        type: 'get'
        url: '/api/mes'
        success: (data) ->
          self.data = data
          self.update()
      )

  </script>

</pb-listing>