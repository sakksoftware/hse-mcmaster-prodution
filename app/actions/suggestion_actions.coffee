config = require('config')[window.ENV]
if config.useMocks
  module.exports = require('mocks/actions/suggestion_actions')
  return

SuggestionActions = Reflux.createActions
  suggestions: {asyncResult: true}

SuggestionActions.suggestions.listen (search, language) ->
  API.read("search/suggestions#{serializeSearchUrl(search, language)}").
    done(@completed).fail(@failed)

module.exports = SuggestionActions
