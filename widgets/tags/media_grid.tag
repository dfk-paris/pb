<pb-media-grid>

  <div if={!opts.expand} class="pb-grid">
    <div class="pb-cell" each={medium in opts.se.media}>
      <img src={medium.urls.thumb} />
    </div>

    <div class="w-clearfix"></div>
  </div>

  <div if={opts.expand} class="pb-list">
    <div class="pb-item" each={medium in opts.se.media}>
      <img src={medium.urls.normal} />
    </div>
  </div>

</pb-media-grid>