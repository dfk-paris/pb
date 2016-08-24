<pb-pagination>

  <div class="u-text-right" show={total_pages() > 1}>
    <a onclick={page_to(opts.page, -1)}><i class="fa fa-chevron-circle-left"></i></a>
    {opts.page}/{total_pages()}
    <a onclick={page_to(opts.page, +1)}><i class="fa fa-chevron-circle-right"></i></a>
  </div>

  <script type="text/coffee">
    self = this

    self.page_to = (old_page, change) ->
      new_page = parseInt(old_page) + change
      (event) ->
        if new_page >= 1 && new_page <= self.total_pages()
          riot.route("mes?page=#{new_page}")
          # if handler = self.opts.onchange
          #   handler(new_page)

    self.total_pages = -> 
      console.log self.opts
      Math.ceil(self.opts.total / self.opts.per_page)
  </script>

</pb-pagination>