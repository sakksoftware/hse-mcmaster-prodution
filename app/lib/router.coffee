class Router
  update: (url) ->
    if (window.history?.pushState?)
      window.history.pushState(null, "HSE", url)
    else
      window.location.hash = url

module.exports = new Router