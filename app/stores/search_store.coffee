API = require('lib/api')
SearchActions = require('actions/search_actions')

module.exports = Reflux.createStore
  listenables: [SearchActions]

  search: (query, success, error, options = {}) ->
    options = _.extend {sortBy: 'relevance'}, options

    API.read "search?q=#{query}&sort_by=#{options.sortBy}",
      success: success,
      error: error