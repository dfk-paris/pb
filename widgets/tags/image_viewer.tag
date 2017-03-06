<pb-image-viewer>
  <img src="{url()}">

  <script type="text/coffee">
    tag = this

    tag.url = ->
      if window.location.href.match(/localhost:3000/)
        '/dummy.jpg'
      else
        tag.opts.url
  </script>
</pb-image-viewer>