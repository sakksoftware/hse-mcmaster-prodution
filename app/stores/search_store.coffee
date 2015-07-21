API = require('lib/api')
SearchActions = require('actions/search_actions')

module.exports = Reflux.createStore
  listenables: [SearchActions]

  search: (query, success, error, options = {}) ->
    options = _.extend {sortBy: 'relevance', filters: []}, options
    filters = _(options.filters).pluck('id').join(";")

    API.read "search?q=#{query}&sort_by=#{options.sortBy}&filters=#{filters}",
      success: success,
      error: error

  suggestions: (query, success, error, options = {}) ->
    # TODO: UPDATE BACK TO THIS VERSION ONCE BOSE IMPLEMENTS IT ON THE API
    #API.read "search/suggestions?q=#{query}",
    API.read "suggestions?q=#{query}",
      success: success,
      error: error