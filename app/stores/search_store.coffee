API = require('lib/api')
SearchActions = require('actions/search_actions')

module.exports = Reflux.createStore
  listenables: [SearchActions]

  search: (query, success, error) ->
    API.read "search?q=#{query}",
      success: success,
      error: error