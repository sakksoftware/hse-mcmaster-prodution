config = require('config')[window.ENV]
if config.useMocks
  return module.exports = require('mocks/actions/search_actions')

API = require('lib/api')
serializeSearchUrl = require('services/search_serialization_service').serializeSearchUrl

SearchActions = Reflux.createActions
  search: {asyncResult: true}
  suggestions: {asyncResult: true}

SearchActions.search.listen (search, language) ->
  API.read("search#{serializeSearchUrl(search, language)}").
    done(@completed).fail(@failed)

SearchActions.suggestions.listen (search, language) ->
  API.read("search/suggestions#{serializeSearchUrl(search, language)}").
    done(@completed).fail(@failed)

module.exports = SearchActions
