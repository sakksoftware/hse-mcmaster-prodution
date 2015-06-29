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
    options = $.extend {
      url: "/api/#{url}"
      method: method
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