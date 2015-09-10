config = require('config')

module.exports = class API
  @read: (url, options = {}) ->
    @send(url, "GET", {}, options)

  @create: (url, data, options = {}) ->
    @send(url, "POST", data, options)

  @update: (url, data, options = {}) ->
    @send(url, "PUT", data, options)

  @destroy: (url, options = {}) ->
    @send(url, "DELETE", {}, options)

  @send: (url, method, data = null, options = {}) ->
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
      success: [options.success || (->), @onSuccess]
      error: [options.error || (->), @onError]
    }, options

    if options.method != 'GET'
      options.data = JSON.stringify(data)

    $.ajax options

  @onSuccess: (res, status) ->
    if ENV is 'production'
      return

    console.debug "[API] Successfully got: ", res

  @onError: (res, status) ->
    # TODO: redirect to error pages generic if user can't recover from the error
    # Otherwise give a chance for the component for handle this
    if res.status == 503
      flash 'error', 'Service is unavilable, please try <a href=".">refreshing the page</a>.
        If you continue seeing this, please contact us at
        <a target="_blank" href="mailto:michael.yagudaev@func-i.com">michael.yagudaev@func-i.com</a>'

    if ENV is 'production'
      return

    console.debug "[API] Error: ", res

  @_isRelativePath: (url) ->
    url.substr(0, 4) != 'http' and url.substr(0, 3) != 'ws:'
