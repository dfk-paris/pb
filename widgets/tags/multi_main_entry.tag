<pb-multi-main-entry>

  <div class="controls w-text-right no-print">
    <button onclick={newSearch}>neue Suche</button>
    <button onclick={print}>drucken</button>
    <button onclick={close}>schließen</button>
    <button onclick={toggleExpand}>Abbildungen vergrößern/verkleinern</button>

    <hr class="no-print" />
  </div>


  <virtual each={id in opts.mes}>
    <pb-main-entry id={id} omit-controls={true} ref="entries" />
    <div class="me-separator">
      <hr width="75%" />
      <hr width="75%" />
    </div>
  </virtual>

  <script type="text/coffee">
    tag = this
    window.t2 = tag

    tag.newSearch = (event) ->
      tag.close()
      for form in Zepto('pb-search-form form')
        form.reset()
      wApp.routing.path('/')

    tag.print = (event) ->
      wApp.utils.printElement(tag.root);

    tag.close = (event) ->
      c() if c = tag.opts.close

    tag.toggleExpand = (event) ->
      if Zepto.isArray(tag.refs['entries'])
        for t in tag.refs['entries']
          t.expand = !t.expand
      tag.update()

  </script>

</pb-multi-main-entry>