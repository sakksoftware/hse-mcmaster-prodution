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
      timeout: 30 * 1000
      beforeSend: (xhr) =>
        if token = Cookies.get('token')
          xhr.setRequestHeader('Authorization', token)
      success: [options.success || (->), @onSuccess]
      error: [options.error || (->), @onError(options.skipErrorHandlingFor)]
    }, options

    if options.method != 'GET'
      options.data = JSON.stringify(data)

    $.ajax options

  @onSuccess: (res, status) ->
    if ENV is 'production'
      return

    console.debug "[API] Successfully got: ", res

  @onError: (errorsToSkip = []) ->
    (res, errorTypeText) =>
      errorsToSkip = [errorsToSkip] unless _.isArray(errorsToSkip)
      return if errorsToSkip.indexOf(res.status) >= 0

      router = require('lib/router')

      if res.status >= 500 && res.status <= 599
        router.render('/5xx')
      else if res.status == 403
        Rollbar.error('Quota Exceeded Error', res)
        router.render('/403')
      else if res.status == 404
        router.render('/404')
      else if (res.status >= 400 && res.status <= 499 && res.status != 422) || (res.status == 0 && errorTypeText == 'error')
        Rollbar.error('Application Error', res)
        router.render('/4xx')
      else if errorTypeText == 'parsererror'
        Rollbar.error('parse error', res)
        router.render('/5xx')
      else if errorTypeText == 'timeout'
        Rollbar.error('request timedout', res)
        router.render('/timeout')

      if ENV is 'production'
        return

        console.debug "[API] Error: ", res

  @_isRelativePath: (url) ->
    url.substr(0, 4) != 'http' and url.substr(0, 3) != 'ws:'
