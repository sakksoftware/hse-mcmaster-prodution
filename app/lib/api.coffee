config = require('config')[window.ENV]

module.exports = class API
  @read: (url, options = {}) ->
    @send(url, "GET", {}, options)

  @create: (url, data, options = {}) ->
    @send(url, "POST", data, options)

  @update: (url, data, options = {}) ->
    @send(url, "PUT", data, options)

  @destroy: (url, options = {}) ->
    @send(url, "DELETE", {}, options)

  @send: (url, method, data = {}, options = {}) ->
    if @_isRelativePath(url)
      if url[0] != '/'
        url = '/' + url

      parser = document.createElement('a')
      parser.href = url
      path = parser.pathname
      path = '/' + path if path[0] != '/'

      if ENV is 'development'
        url = "/fake_api" + path + ".json" + parser.search + parser.hash
      else
        url = path + parser.search + parser.hash
        url = config.apiBase + "/api#{url}"

    options = $.extend {
      url: url
      method: method
      contentType: 'application/json; charset=UTF-8' # always send json to the server
      dataType: options.dataType || 'json' # always recieve json back from the server
      beforeSend: (xhr) =>
        if token = Cookies.get('token')
          xhr.setRequestHeader('Authorization', token)
      data: JSON.stringify(data)
      success: [options.success || (->), @onSuccess]
      error: [options.error || (->), @onError]
    }, options

    $.ajax options

  @onSuccess: (res, status) ->
    if ENV is 'production'
      return

    console.debug "[API] Successfully got: ", res

  @onError: (res, status) ->
    if ENV is 'production'
      return

    console.debug "[API] Error: ", res

  @_isRelativePath: (url) ->
    url.substr(0, 4) != 'http' and url.substr(0, 3) != 'ws:'
