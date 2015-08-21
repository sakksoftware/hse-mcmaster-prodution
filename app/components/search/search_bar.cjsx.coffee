Input = ReactBootstrap.Input
SearchActions = require('actions/search_actions')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SearchBar'

  mixins: [TranslationHelper]
  baseTranslation: 'search_page.search_box'

  propTypes:
    query: React.PropTypes.string
    onSearch: React.PropTypes.func.isRequired

  dismissKeyboard: -> document.activeElement.blur()
  handleSubmit: (e) ->
    e.preventDefault()
    @props.onSearch?(document.getElementById('search').value)
    @dismissKeyboard()

  fetchSuggestions: (query, callback) ->
    handleLoadSuggestions = (data) -> callback(null, data.suggestions)
    handleError = -> console.log('Error: cannot load suggestions')
    SearchActions.suggestions query, handleLoadSuggestions, handleError

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
      value: @props.query
      id: 'search'
      ref: 'search'

    <form action="#" onSubmit={@handleSubmit} className="search-bar">
      <Autosuggest
        suggestions={@fetchSuggestions}
        suggestionValue={@getSuggestionValue}
        suggestionRenderer={@renderSuggestion}
        inputAttributes={inputAttributes}
      />
    </form>
