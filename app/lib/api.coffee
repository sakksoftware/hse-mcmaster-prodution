config = require('config')[window.ENV]

module.exports = class API
  @read: (url, options = {}) ->
    @send(url, "GET", {}, options)

  @create: (url, data, options = {}) ->
    @send(url, "POST", data, options)

  @update: (url, data, options = {}) ->
    @send(url, "PATCH", data, options)

  @destroy: (url, options = {}) ->
    @send(url, "DELETE", {}, options)

  @send: (url, method, data = {}, options = {}) ->
    parser = document.createElement('a')
    # TODO: this doesn't handle absolute paths properly
    # needs more work....
    if url[0] != '/' and url.substr(0, 4) != 'http' and url.substr(0, 3) != 'ws:'
      url = '/' + url

    path = parser.href = url

    if ENV is 'development'
      url = "/fake_api" + path + ".json" + parser.search + parser.hash
    else
      url = path + parser.search + parser.hash
      url = config.apiBase + "/api#{url}"

    options = $.extend {
      url: url
      method: method
      dataType: options.dataType || 'json' # always recieve json back from the server
      # uncomment if rails for CSRF protection
      # beforeSend: (xhr) =>
      #   xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      data: data
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
