Input = ReactBootstrap.Input
SuggestionActions = require('actions/suggestion_actions')
TranslationHelper = require('mixins/translation_helper')
UserStore = require('stores/user_store')

module.exports = React.createClass
  displayName: 'SearchBar'

  mixins: [TranslationHelper]
  baseTranslation: 'search_page.search_box'

  propTypes:
    search: React.PropTypes.object
    onSearch: React.PropTypes.func.isRequired

  dismissKeyboard: -> document.activeElement.blur()
  handleSubmit: (e) ->
    e.preventDefault()
    @onSearch(document.getElementById('search').value)

  onSearch: (query) ->
    @props.onSearch?(query)
    @dismissKeyboard()

  fetchSuggestions: (query, callback) ->
    handleLoadSuggestions = (suggestions) -> callback(null, suggestions)
    @props.search.query = query
    SuggestionActions.suggestions(@props.search, UserStore.state.language).then(handleLoadSuggestions)

  getSuggestionValue: (suggestion, input) ->
    suggestion.query

  renderSuggestion: (suggestion, input) ->
    <span>
      <strong>{suggestion.query.slice(0, input.length)}</strong>
      {suggestion.query.slice(input.length)} ({suggestion.count})
    </span>

  render: ->
    inputAttributes =
      placeholder: @t('placeholder')
      value: @props.search.query
      id: 'search'
      ref: 'search'

    <form action="#" onSubmit={@handleSubmit} className="search-bar">
      <Autosuggest
        suggestions={@fetchSuggestions}
        suggestionValue={@getSuggestionValue}
        suggestionRenderer={@renderSuggestion}
        inputAttributes={inputAttributes}
        onSuggestionSelected={(suggestion) => @onSearch(suggestion.query)}
      />
    </form>
