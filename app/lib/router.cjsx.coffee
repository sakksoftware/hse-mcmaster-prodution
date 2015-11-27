App = require('components/app')
# TODO: replace with react router
class Router
  constructor: ->
    window.addEventListener('hashchange', @_handleRouteChange.bind(@))
    window.addEventListener('popstate', @_handleRouteChange.bind(@))

  el: ->
    @_el ||= document.getElementById('react-root')

  routes:
    '/$': ->
      React.render <App page="home" />, @el()

    '^/search': ->
      SearchStore = require('stores/search_store')
      SearchStore.updateStateFromUrl()
      React.render <App page="search" />, @el()

    '^/articles/:id': (id) ->
      React.render <App page="articles" args={id: id} />, @el()

    '^/about': ->
      React.render <App page="about" />, @el()

    '^/terms': ->
      React.render <App page="terms" />, @el()

    '^/profile': ->
      React.render <App page="profile" />, @el()

    '^/complementary_content': ->
      React.render <App page="complementary_content" />, @el()

    '^/forgot_password': ->
      React.render <App page="forgot_password" />, @el()

    '^/reset_password': ->
      React.render <App page="reset_password" />, @el()

    '^/top_5': ->
      React.render <App page="top_5" />, @el()

    '^/login': ->
      React.render <App page="login" />, @el()

    '^/signup': ->
      React.render <App page="signup" />, @el()

    '^/newsletters/:id': (id) ->
      React.render <App page="newsletter" args={id: id}/>, @el()

    '^/unsubscribe': ->
      React.render <App page="unsubscribe" />, @el()

    '^/user/searches': ->
      React.render <App page="saved_search" />, @el()

    '^/user/articles': ->
      React.render <App page="saved_articles" />, @el()

    '^/timeout': ->
      React.render <App page="timeout_error" />, @el()

    '^/cookies_disabled': ->
      React.render <App page="cookies_disabled" />, @el()

    '^/5xx': ->
      React.render <App page="server_error" />, @el()

    '^/4xx': ->
      React.render <App page="application_error" />, @el()

    '^/403': ->
      React.render <App page="quota_exceeded_error" />, @el()

    '^/404': ->
      React.render <App page="page_not_found" />, @el()

    '.*': ->
      @visit('/') # redirect to homepage

  history: []

  back: -> @visit(@history.pop())

  start: ->
    if !window.history || !window.history.pushState
      if window.location.pathname != '' && window.location.pathname != '/' && !window.location.pathname.match(/^\/\?/)
        path = window.location.pathname
        path = '/' + path if path[0] != '/'
        window.location = '/#!' + window.location.pathname
        return

    @_handleRouteChange()

  visit: (url) ->
    @update(url)
    @_handleRouteChange()
    window.scrollTo(0, 0)

  update: (url) ->
    if window.history?.pushState?
      @history.push(window.location.pathname + window.location.search)
      window.history.pushState(null, "HSE", url)
    else
      @history.push(@_getHash())
      url = '/' + url if url[0] != '/'
      window.location.hash = '!' + url

  hasHistory: -> @history.length > 0

  getPath: ->
    if window.history?.pushState?
      path = window.location.pathname
    else
      path = @_getHash().replace(/\?.+/, '')

    path = '/' + path if path[0] != '/'
    path

  render: (path) ->
    [action, params] = @_findActionFor(path)

    throw new Error("Cannot find action for path #{path}") unless action
    action.apply(@, params)

  _handleRouteChange: ->
    path = @getPath()
    @render(path)

  _getHash: ->
    window.location.hash.replace(/^#!\//, '')

  _findActionFor: (path) ->
    params = []
    if action = @routes[path]
    else
      $.each @routes, (key, value) =>
        pattern = key.replace new RegExp(@urlParamsPattern, 'g'), @urlParamValuePattern
        if matches = path.match new RegExp(pattern)
          action = value
          matches.splice(0, 1)
          params = matches
          return false # break out of the loop

    [action, params]

  urlParamsPattern: ':([a-zA-Z_0-9$]*)'
  urlParamValuePattern: '([^/]*)'

module.exports = new Router
