config = require('config')
if config.useMocks
  module.exports = require('mocks/actions/suggestion_actions')
  return

API = require('lib/api')
SearchSerializationService = require('services/search_serialization_service')

SuggestionActions = Reflux.createActions
  suggestions: {asyncResult: true}

SuggestionActions.suggestions.listen (search, language) ->
  query = SearchSerializationService.serializeSearchUrl(search, language)
  API.read("search/suggestions#{query}").
    done(@completed).fail(@failed)

module.exports = SuggestionActions
