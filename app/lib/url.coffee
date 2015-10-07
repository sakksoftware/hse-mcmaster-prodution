module.exports =
  params: ->
    match = null
    pl = /\+/g
    search = /([^&=]+)=?([^&]*)/g

    decode = (s) ->
      decodeURIComponent s.replace(pl, ' ')

    query = window.location.search.substring(1)
    urlParams = {}
    while match = search.exec(query)
      urlParams[decode(match[1])] = decode(match[2])

    urlParams

  serializeParams: (params) ->
    result = _(params).map((v, k) -> "#{k}=#{v}" if v)
    result = _(result).compact().join('&')
    "?#{result}"
