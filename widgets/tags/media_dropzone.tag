<pb-media-dropzone>

  <div data-id="dropzone-tpl" style="display: none">

    <div class="dz-preview dz-file-preview">
      <div class="dz-image"><img data-dz-thumbnail /></div>
      <div class="dz-details">
        <!-- <div class="dz-size"><span data-dz-size></span></div> -->
        <!-- <div class="dz-filename"><span data-dz-name></span></div> -->
        <div class="dz-caption" data-dz-caption></div>
      </div>
      <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>
      <div class="dz-error-message"><span data-dz-errormessage></span></div>
      <div class="dz-success-mark"><i class="fa fa-check"></i></div>
      <div class="dz-error-mark"><i class="fa fa-remove"></i></div>
      <!-- <div class="dz-remove" data-dz-remove>
        <i class="fa fa-remove"></i>
      </div> -->
    </div>

  </div>

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
    self.media_added = false
    window.x = self

    self.on 'mount', ->
      self.dropzone = new Dropzone($(self.root).find('.dropzone')[0],
        url: "/api/ses/#{self.opts.subEntryId}/media"
        method: 'post'
        paramName: 'medium[image]'
        previewTemplate: $('[data-id=dropzone-tpl]')[0].innerHTML
        addRemoveLinks: true
        removedfile: (file) ->
          $.ajax(
            type: 'delete'
            url: "/api/ses/#{self.opts.subEntryId}/media/#{file.id}"
            success: (data) ->
              $(file.previewElement).remove()
              if self.opts.media.length > 0
                $(self.root).find('.dz-message').hide()
          )
      )

      self.dropzone.on 'addedfile', (file) ->
        $(file.previewTemplate).attr('data-id', file.id)
        $(file.previewTemplate).find('[data-dz-caption]').html(file.caption)

      self.dropzone.on 'success', (file, response) ->
        $(file.previewTemplate).attr('data-id', response.medium.id)
        $(file.previewTemplate).find('[data-dz-caption]').html(response.medium.caption)

    self.on 'updated', ->
      if self.opts.media && !self.media_added
        self.media_added = true
        for medium in self.opts.media
          file = {
            id: medium.id
            name: medium.file_name
            size: medium.size
            caption: medium.caption
          }
          self.dropzone.emit "addedfile", file
          self.dropzone.createThumbnailFromUrl(file, medium.urls.normal)
          self.dropzone.emit "complete", file
  </script>

</pb-media-dropzone>