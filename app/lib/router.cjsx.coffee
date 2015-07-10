class Router
  routes:
    '': ->
      SearchPage = require('components/search/search_page')
      React.render(<SearchPage />, document.getElementById('react-root'))

    'documents/:id': (id) ->
      DocumentPage = require('components/documents/document_page')
      React.render <DocumentPage id={id} />, document.getElementById('react-root')
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