StoreMock = require('mocks/support/store_mock')
SearchSerializationService = require('services/search_serialization_service')

SuggestionActions = Reflux.createActions
  suggestions: {asyncResult: true}

SuggestionActions.suggestions.listen (search, language) ->
  query = SearchSerializationService.serializeSearchUrl(search, language)
  res = _.filter suggestionData, (s) => s.query.toLowerCase().match(search.query.toLowerCase())
  StoreMock.send(res, (=> @completed(res)), "/search/suggestions#{query}")

module.exports = SuggestionActions

suggestionData = [
  {"query": "HIV", "count": 1544},
  {"query": "HIV Positive", "count": 444},
  {"query": "HIV Research in Africa", "count": 987},
  {"query": "HIV Things", "count": 543}
]
