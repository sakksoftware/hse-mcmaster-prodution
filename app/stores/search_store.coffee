API = require('lib/api')
SearchActions = require('actions/search_actions')
SearchSerializationService = require('services/search_serialization_service')

module.exports = Reflux.createStore
  listenables: [SearchActions]
  mixins: [SearchSerializationService]

  search: (search, success, error) ->
    API.read "search#{@serializeSearchUrl(search)}",
      success: success,
      error: error

  suggestions: (query, success, error, options = {}) ->
    API.read "search/suggestions?q=#{query}",
      success: success,
      error: error
