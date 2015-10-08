Input = ReactBootstrap.Input
SuggestionActions = require('actions/suggestion_actions')
TranslationHelper = require('mixins/translation_helper')
UserStore = require('stores/user_store')
Button = require('components/shared/button')

module.exports = React.createClass
  displayName: 'SearchBar'

  mixins: [TranslationHelper]
  baseTranslation: 'search_page.search_box'

  propTypes:
    search: React.PropTypes.object
    onSearch: React.PropTypes.func.isRequired

  getInitialState: ->
    query: @props.search.query
    # HACK: to clear the
    count: 0

  dismissKeyboard: -> document.activeElement.blur()
  handleSubmit: (e) ->
    e.preventDefault()
    @onSearch(document.getElementById('search').value)

  onSearch: (query) ->
    @props.onSearch?(query)
    @dismissKeyboard()

  fetchSuggestions: (query, callback) ->
    handleLoadSuggestions = (suggestions) ->
      suggestions = _.clone(suggestions)
      if suggestions.length == 0 || suggestions[0].query.toLowerCase() != query.toLowerCase()
        suggestions.splice(0, 0, {query: query, count: null})
      callback(null, suggestions)
    @props.search.query = query
    SuggestionActions.suggestions(@props.search, UserStore.state.language).then(handleLoadSuggestions)

  getSuggestionValue: (suggestion, input) ->
    suggestion.query

  clearInput: ->
    @setState(query: '', count: ++@state.count)
    router = require('lib/router')
    router.visit('/')

  renderSuggestion: (suggestion, input) ->
    # TODO: add back suggestion count below once we have it implemented
    # ({suggestion.count})
    index = suggestion.query.toLowerCase().indexOf(input.toLowerCase())
    if index >= 0
      start = suggestion.query.slice(0, index)
      match = suggestion.query.slice(index, index + input.length)
      end = suggestion.query.slice(index + input.length)
      <span>
        {start}
        <strong>{match}</strong>
        {end}
      </span>
    else
      <span>
        {suggestion.query}
      </span>

  render: ->
    inputAttributes =
      placeholder: @t('placeholder')
      value: @state.query
      id: 'search'
      ref: 'search'

    <form ref="searchForm" action="#" onSubmit={@handleSubmit} className="search-bar">
      <Autosuggest
        key={"autosuggest-#{@state.count}"}
        suggestions={@fetchSuggestions}
        suggestionValue={@getSuggestionValue}
        suggestionRenderer={@renderSuggestion}
        inputAttributes={inputAttributes}
        onSuggestionSelected={(suggestion) => @onSearch(suggestion.query)}
      />
      <Button className="btn-clear" onClick={@clearInput}>&#x00D7;</Button>
    </form>
