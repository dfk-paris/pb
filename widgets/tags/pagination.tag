<pb-pagination>

  <div class="w-float-left">
    {opts.total} Resultate
  </div>

  <div class="u-text-right" show={total_pages() > 1}>
    Seite
    <a
      show={!is_first()}
      onclick={page_to_first}
    ><i class="fa fa-angle-double-left"></i></a>
    <a
      show={!is_first()}
      onclick={page_down}
    ><i class="fa fa-angle-left"></i></a>
    <form submit={jump}>
      <pb-input
        ref="jump"
        value={opts.page}
      />
    </form>
    / {total_pages()}
    <a
      show={!is_last()}
      onclick={page_up}
    ><i class="fa fa-angle-right"></i></a>
    <a
      show={!is_last()}
      onclick={page_to_last}
    ><i class="fa fa-angle-double-right"></i></a>
  </div>

  <div class="w-clearfix"></div>

  <script type="text/coffee">
    tag = this

    tag.current_page = -> parseInt(wApp.routing.query()['page'] || 1)
    tag.page_to_first = (event) ->
      event.preventDefault()
      tag.page_to(1)
    tag.page_down = (event) ->
      event.preventDefault()
      tag.page_to(tag.current_page() - 1)
    tag.page_up = (event) ->
      event.preventDefault()
      tag.page_to(tag.current_page() + 1)
    tag.page_to_last = (event) -> 
      event.preventDefault()
      tag.page_to(tag.total_pages())
    tag.is_first = -> tag.current_page() == 1
    tag.is_last = -> tag.current_page() == tag.total_pages()

    tag.page_to = (newPage) ->
      if opts.pageTo
        opts.pageTo(newPage)
      else
        if newPage != tag.current_page() && newPage >= 1 && newPage <= tag.total_pages()
          wApp.routing.query page: newPage

    tag.total_pages = ->
      Math.ceil(tag.opts.total / tag.opts.perPage)

    tag.jump = (event) ->
      event.preventDefault()
      newPage = parseInt(tag.refs.jump.value())
      tag.page_to(newPage)

  </script>

</pb-pagination>