<pb-media-grid>

  <div if={!opts.expand} class="pb-grid">
    <div class="pb-cell" each={medium in media()}>
      <img src={wAppApiUrl + medium.urls.thumb} />
    </div>

    <div class="w-clearfix"></div>
  </div>

  <div if={opts.expand} class="pb-list">
    <div class="pb-item" each={medium in media()}>
      <img src={wAppApiUrl + medium.urls.normal} />
      <div class="pb-caption">{medium.caption}</div>
    </div>
  </div>

  <script type="text/coffee">
    tag = this

    tag.media = ->
      # console.log tag.opts.se.media
      tag.mediaCache ||= (m for m in tag.opts.se.media when m.publish)
  </script>

</pb-media-grid>