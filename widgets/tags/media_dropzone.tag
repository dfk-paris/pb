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
      self.dropzone = new Dropzone($(self.root).find('.dropzone')[0],
        url: "/api/ses/#{self.opts.subEntryId}/media"
        method: 'post'
        paramName: 'medium[image]'
        # previewTemplate: $("script[data-id=dropzone-tpl]")[0].innerHTML
        # addRemoveLinks: true
        # removedfile: (file) ->
        #   $.ajax(
        #     type: 'delete'
        #     url: "/api/ses/#{self.opts.subEntryId}/media/#{file.id}"
        #     success: (data) ->
        #       $(file.previewElement).remove()
        #       if self.opts.media.length > 0
        #         $(self.root).find('.dz-message').hide()
        #   )
      )

      # self.dropzone.on 'addedfile', (file) ->
      #   $(file.previewTemplate).attr('data-id', file.id)
      #   $(file.previewTemplate).find('[data-dz-caption]').html(
      #     wApp.utils.shorten(file.caption)
      #   )
      #   # console.log file
      #   riot.mount $(file.previewElement).find('pb-button')[0], 'pb-button'
      #   $(file.previewElement).on 'click', 'pb-button', (event) ->
      #     event.preventDefault()
      #     wApp.trigger 'modal', 'pb-file-editor', {
      #       'subEntryId': self.opts.subEntryId
      #       'item': file
      #     }

      self.dropzone.on 'success', (file, response) ->
        wApp.bus.trigger 'pb-load-data'
        self.dropzone.removeFile(file)
        # $(file.previewTemplate).attr('data-id', response.medium.id)
        # $(file.previewTemplate).find('[data-dz-caption]').html(response.medium.caption)

    # self.on 'updated', ->
    #   console.log 'again!'
    #   if self.opts.media
    #     self.dropzone.emit 'reset'
    #     for medium in self.opts.media
    #       file = {
    #         id: medium.id
    #         name: medium.file_name
    #         size: medium.size
    #         caption: medium.caption
    #       }
    #       self.dropzone.emit "addedfile", file
    #       self.dropzone.createThumbnailFromUrl(file, medium.urls.normal)
    #       self.dropzone.emit "complete", file

  </script>

</pb-media-dropzone>