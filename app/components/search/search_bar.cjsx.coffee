Input = ReactBootstrap.Input
SearchActions = require('actions/search_actions')

module.exports = React.createClass
  displayName: 'SearchBar'
  propTypes:
    query: React.PropTypes.string.isRequired
    onSearch: React.PropTypes.func.isRequired

  handleSubmit: (e) ->
    e.preventDefault()
    @props.onSearch?(@refs.search.lastSuggestionsInputValue)

  fetchSuggestions: (query, callback) ->
    handleLoadSuggestions = (data) -> callback(null, data.suggestions)
    handleError = -> console.log('Error: cannot load suggestions')
    SearchActions.suggestions query, handleLoadSuggestions, handleError

  renderSuggestion: (suggestion, input) ->
    <span>
      <strong>{suggestion.query.slice(0, input.length)}</strong>
      {suggestion.query.slice(input.length)} ({suggestion.count})
    </span>

  render: ->
    <form action="#" onSubmit={@handleSubmit} className="search-bar">
      <Autosuggest suggestions={@fetchSuggestions} suggestionRenderer={@renderSuggestion} ref="search" />
      <button>Search</button>
    </form>