App = require('components/app')
class Router
  constructor: ->
    @el = document.getElementById('react-root')
    window.addEventListener('hashchange', @handleRouteChange.bind(@))
    window.addEventListener('popstate', @handleRouteChange.bind(@))

  routes:
    '': ->
      React.render <App page="search" />, @el

    'articles/:id': (id) ->
      args = {id: id}
      React.render <App page="articles" args={args} />, @el

    'about': ->
      React.render <App page="about" />, @el

    'terms': ->
      React.render <App page="terms" />, @el

    'profile': ->
      React.render <App page="profile" />, @el

    'complementary_content': ->
      React.render <App page="complementary_content" />, @el

  history: []

  back: -> @visit(@history.pop())

  start: ->
    @handleRouteChange()

  visit: (url) ->
    @update(url)
    @handleRouteChange()

  update: (url) ->
    if (window.history?.pushState?)
      @history.push(window.location.pathname + window.location.search)
      window.history.pushState(null, "HSE", url)
    else
      @history.push(window.location.hash)
      window.location.hash = url

  hasHistory: -> @history.length > 0

  handleRouteChange: ->
    path = @getPath()
    [action, params] = @findActionFor(path)

    throw new Error("Cannot find action for path #{path}") unless action
    action.apply(@, params)

  getPath: ->
    if (window.history?.pushState?)
      window.location.pathname
    else
      window.location.hash

  findActionFor: (path) ->
    params = []
    if action = @routes[path]
    else
      $.each @routes, (key, value) =>
        pattern = key.replace new RegExp(@urlParamsPattern, 'g'), @urlParamValuePattern
        if matches = path.match new RegExp(pattern)
          action = value
          matches.splice(0, 1)
          params = matches

    [action, params]

  urlParamsPattern: ':([a-zA-Z_0-9$]*)'
  urlParamValuePattern: '([^/]*)'

module.exports = new Router
