config = require('config')

module.exports = class API
  @interceptors: []

  @read: (url, options = {}) ->
    @send(url, "GET", {}, options)

  @create: (url, data, options = {}) ->
    @send(url, "POST", data, options)

  @update: (url, data, options = {}) ->
    @send(url, "PUT", data, options)

  @destroy: (url, options = {}) ->
    @send(url, "DELETE", {}, options)

  @send: (url, method, data = null, options = {}) ->
    fetch = window.fetch
    if interceptor = @findInterceptor(url, method)
      fetch = interceptor

    if @_isRelativePath(url)
      if url[0] != '/'
        url = '/' + url

      parser = document.createElement('a')
      parser.href = url
      path = parser.pathname
      path = '/' + path if path[0] != '/'

      apiBase = options.apiBase || config.apiBase

      url = path + parser.search + parser.hash
      url = apiBase + "/api#{url}"

    headers = {}
    if token = Cookies.get('token')
      headers['Authorization'] = token

    options = _.extend {
      method: method
      contentType: 'application/json; charset=UTF-8' # always send json to the server
      dataType: options.dataType || 'json' # always receive json back from the server
      timeout: 30 * 1000
      headers: headers
    }, options

    if options.method != 'GET'
      options.data = JSON.stringify(data)

    fetch(url, options)
      .then(@_checkStatus(options.skipErrorHandlingFor))
      .then(@_parseJSON)

  @onSuccess: (res, status) ->
    if ENV is 'production'
      return

    console.debug "[API] Successfully got: ", res

  @onError: (res, errorTypeText, errorsToSkip = []) =>
    errorsToSkip = [errorsToSkip] unless _.isArray(errorsToSkip)
    return if errorsToSkip.indexOf(res.status) >= 0

    router = require('lib/router')

    if res.status >= 500 && res.status <= 599
      router.render('/5xx')
    else if res.status == 403
      # TODO: complicated logic, does this really belong here?
      UserStore = require('stores/user_store')
      if UserStore.state.user
        Rollbar.error('Quota Exceeded Error (guest user)', res)
        router.render('/403')
      else
        Rollbar.error('Quota Exceeded Error (registered user)', res)

        TranslationHelper = require('mixins/translation_helper')
        helper = _.extend({baseTranslation: 'errors'}, TranslationHelper)
        flash('error', helper.t('signup_to_increase_limit'))
        router.visit('/signup')
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

  @registerInterceptor: (url, method, callback) ->
    unless callback
      callback = method
      method = 'GET'

    @interceptors.push({url: url, method: method, callback: callback})

  @findInterceptor: (url, method) ->
    record = @interceptors.find (interceptor) ->
      url.match(interceptor.url) && method == interceptor.method

    record?.callback

  @_isRelativePath: (url) ->
    url.substr(0, 4) != 'http' and url.substr(0, 3) != 'ws:'

  @_checkStatus: (skipErrorHandlingFor) ->
    (response) ->
      if (response.status >= 200 && response.status < 300)
        return response
      else
        error = new Error(response.statusText)
        error.response = response
        throw error
        @onError(response, response.statusText, skipErrorHandlingFor)

  @_parseJSON: (response) ->
    response.json()
