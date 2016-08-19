<pb-modal>

  <div name="receiver">
    <yield />
  </div>

  <style type="text/scss">
    pb-modal, [data-is=pb-modal] {
      [name=receiver] {
        background-color: white;
      }
    }
  </style>

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      console.log 'mounted'

    self.on 'open', ->
      self.modal ||= $(self.receiver).easyModal(
        zIndex: -> 9999
      )
      self.modal.trigger 'openModal'

    self.on 'close', ->
      self.modal.trigger 'closeModal'

  </script>

</pb-modal>