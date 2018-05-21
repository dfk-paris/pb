<pb-special-render>
  <script type="text/javascript">
    var tag = this;

    tag.on('mount', function() {
      render()
    })

    tag.on('updated', function() {
      render()
    })

    var render = function() {
      init();
      if (tag.opts.taggedText) {taggedText()}
      if (tag.opts.highlightFields) {highlight()}
      noPropagation();
    }

    var init = function() {
      Zepto(tag.root).html(tag.opts.riotValue)
    }

    var highlight = function() {
      wApp.utils.highlightFieldsInElement(tag.opts.highlightFields, tag.root);
    }

    var taggedText = function() {
      wApp.utils.taggedText(tag.root, tag.opts.riotValue);
    }

    var noPropagation = function() {
      Zepto(tag.root).find('a').on('click', function(event) {
        event.stopPropagation()
      })
    }
  </script>
</pb-special-render>