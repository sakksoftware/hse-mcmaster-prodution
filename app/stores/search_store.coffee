SearchActions = require('actions/search_actions')
SearchDeserializationService = require('services/search_deserialization_service')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [SearchActions]
  mixins: [RefluxStateMixin, SearchDeserializationService]

  getInitialState: ->
    search: @deserializeSearchUrl()
    suggestions: []
    errors: null

  onSearchCompleted: (search) ->
    if search.page > 1
      search.results = @state.search.results.concat(search.results)

    @setState(search: search, errors: null)
    @trigger(@state)

  onSearchFailed: () ->
    console.log('The search has failed')
    # flash('error', @t('errors.no_connection'))

  onSuggestionsCompleted: (suggestions) ->
    @setState(suggestions: suggestions)
    @trigger(@state)

  onSuggestionsFailed: () ->
    console.log('Failed to retrieve suggestions')
