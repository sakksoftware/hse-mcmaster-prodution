API = require('lib/api')
SearchActions = require('actions/search_actions')
SearchSerializationService = require('services/search_serialization_service')

module.exports = Reflux.createStore
  listenables: [SearchActions]
  mixins: [SearchSerializationService]

  search: (search, language, success, error) ->
    API.read "search#{@serializeSearchUrl(search, language)}",
      success: success,
      error: error

  suggestions: (search, language, success, error, options = {}) ->
    API.read "search/suggestions#{@serializeSearchUrl(search, language)}",
      success: success,
      error: error
