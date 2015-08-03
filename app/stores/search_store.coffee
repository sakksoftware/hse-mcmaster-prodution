API = require('lib/api')
SearchActions = require('actions/search_actions')

module.exports = Reflux.createStore
  listenables: [SearchActions]

  search: (query, success, error, options = {}) ->
    options = _.extend {sortBy: 'relevance', filters: []}, options
    applied_filters = _(options.applied_filters).pluck('id').join(";")

    API.read "search?q=#{query}&sort_by=#{options.sortBy}&applied_filters=#{applied_filters}",
      success: success,
      error: error

  suggestions: (query, success, error, options = {}) ->
    API.read "search/suggestions?q=#{query}",
      success: success,
      error: error
