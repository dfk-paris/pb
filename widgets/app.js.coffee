Dropzone.autoDiscover = false

api_url = Zepto('script[pb-api-url]').attr('pb-api-url')

Zepto.extend Zepto.ajaxSettings, {
  dataType: 'json'
  contentType: 'application/json'
  beforeSend: (xhr, settings) ->
    if api_url
      settings.url = "#{wApp.api_url}#{settings.url}"
}

window.wApp = {
  bus: riot.observable()
  data: {}
}
