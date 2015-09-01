SuggestionActions = require('actions/suggestion_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [SuggestionActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    suggestions: []
    loaded: false
    errors: null

  onSuggestionsCompleted: (suggestions) ->
    @setState(suggestions: suggestions, loaded: true)

  onSuggestionsFailed: ->
    console.log('Failed to retrieve suggestions')
