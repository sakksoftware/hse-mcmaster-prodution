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