Input = ReactBootstrap.Input
SuggestionActions = require('actions/suggestion_actions')
UrlActions = require('actions/url_actions')
TranslationHelper = require('mixins/translation_helper')
UserStore = require('stores/user_store')
SearchStore = require('stores/search_store')
Button = require('components/shared/button')

API = require('lib/api')
SearchSerializationService = require('services/search_serialization_service')

module.exports = React.createClass
  displayName: 'SearchBar'

  mixins: [TranslationHelper]
  baseTranslation: 'search_page.search_box'

  propTypes:
    search: React.PropTypes.object
    onSearch: React.PropTypes.func.isRequired

  getInitialState: ->
    query: @props.search.query
    # HACK: to clear the autosuggest state
    count: 0

  componentWillMount: ->
    @lastSuggestions = []
    @searchSubmitted = false

  componentWillReceiveProps: (nextProps) ->
    @lastSuggestions = []
    @searchSubmitted = false
    @setState(query: nextProps.search.query, count: @state.count + 1)

  dismissKeyboard: -> document.activeElement.blur()
  handleSubmit: (e) ->
    e.preventDefault()
    query = document.getElementById('search').value
    if query == @lastSuggestions[0]?.query
      @onSearch(@lastSuggestions[0])
    else
      @onSearch({query: query})

  onSearch: (suggestion) ->
    @props.onSearch?(suggestion)
    @dismissKeyboard()

  fetchSuggestions: (query, callback) ->
    handleLoadSuggestions = (suggestions) =>
      @lastSuggestions = _.clone(suggestions)
      callback(null, @lastSuggestions)

    @props.search.query = query
    query = SearchSerializationService.serializeSearchUrl(@props.search, UserStore.state.language)
    @request?.abort()
    @request = API.read("search/suggestions#{query}").done(handleLoadSuggestions)

  getSuggestionValue: (suggestion, input) ->
    suggestion.query

  clearInput: ->
    @onSearch('')

  renderSuggestion: (suggestion, input) ->
    index = suggestion.query.toLowerCase().indexOf(input.toLowerCase())

    suggestionCount = ""
    if suggestion.count
      suggestionCount = <span className="suggestion-count">({suggestion.count})</span>

    if index >= 0
      start = suggestion.query.slice(0, index)
      match = suggestion.query.slice(index, index + input.length)
      end = suggestion.query.slice(index + input.length)
      <span>
        {start}
        <strong>{match}</strong>
        {end}
        {suggestionCount}
      </span>
    else
      <span>
        {suggestion.query}
        {suggestionCount}
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
        suggestions={_.debounce(@fetchSuggestions, 200)}
        suggestionValue={@getSuggestionValue}
        suggestionRenderer={@renderSuggestion}
        inputAttributes={inputAttributes}
        # delay transitioning to the new page to prevent odd scroll bug when users
        # clicks on a suggestion (mouse click) it will scroll to bottom of the page.
        onSuggestionSelected={(suggestion) => _.delay((=> @onSearch(suggestion)), 10)}
        cache={false}
      />
      <Button className="btn-clear" onClick={@clearInput}>&#x00D7;</Button>
    </form>
