Dropzone.autoDiscover = false

wAppApiUrl = Zepto('script[pb-api-url]').attr('pb-api-url') || ''

Zepto.extend Zepto.ajaxSettings, {
  dataType: 'json'
  contentType: 'application/json'
  beforeSend: (xhr, settings) ->
    settings.url = "#{wAppApiUrl}#{settings.url}"
}

window.wApp = {
  bus: riot.observable()
  data: {}
}
