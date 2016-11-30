<pb-media-dropzone>

  <div class="dropzone">
    <div class="dz-message">hier klicken oder Bilder hineinziehen</div>
  </div>

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      self.dropzone = new Dropzone(Zepto(self.root).find('.dropzone')[0],
        url: "/api/ses/#{self.opts.subEntryId}/media"
        method: 'post'
        paramName: 'medium[image]'
      )

      self.dropzone.on 'success', (file, response) ->
        wApp.bus.trigger 'pb-load-data'
        self.dropzone.removeFile(file)

  </script>

</pb-media-dropzone>