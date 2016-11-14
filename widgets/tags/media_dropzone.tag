<pb-media-dropzone>

  <div class="dropzone">
    <div class="dz-message">hier klicken oder Bilder hineinziehen</div>
  </div>

  <style type="text/scss">
    pb-media-dropzone, [data-is=pb-media-dropzone] {
      .dropzone {
        .dz-preview {
          .dz-details {
            position: relative;
            padding: 0px;
            margin-top: 0.5rem;
            text-align: center;
            opacity: 100 !important;
            max-width: 120px;
          }
        }
      }
    }
  </style>

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