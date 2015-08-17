Button = ReactBootstrap.Button
FilterActions = require('actions/filter_actions')
SearchActions = require('actions/search_actions')
SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')
FilterNormalizationService = require('services/filter_normalization_service')
SearchSerializationService = require('services/search_serialization_service')
SearchDeserializationService = require('services/search_deserialization_service')

module.exports = React.createClass
  displayName: 'SearchPage'

  mixins: [FilterNormalizationService, SearchSerializationService, SearchDeserializationService]

  propTypes:
    onShowMenu: React.PropTypes.func.isRequired

  # steps
  # pending_search
  # searching
  # results
  getInitialState: ->
    search: @deserializeSearchUrl()
    step: 'pending_search'

  componentWillMount: ->
    # TODO: remove when passing results as an attribute from server a bit hacky now
    if @state.search.query == null
      @fetchFilters()
    else
      @fetchResults()

  fetchFilters: ->
    FilterActions.loadFilters @handleLoadFilters, @handleError

  fetchResults: ->
    @setState(step: 'searching', search: @state.search)
    SearchActions.search @state.search,
      @handleLoad,
      @handleError

  updateUrl: ->
    Router = require('lib/router')
    Router.update(@serializeSearchUrl(@state.search))

  handleSearch: (query) ->
    @state.search.query = query
    @updateUrl()
    @fetchResults()

  handleSortChange: (sortBy) ->
    @state.search.sort_by = sortBy
    @updateUrl()
    @fetchResults()

  changeFilterValue: (filter, value) ->
    # optimistic update
    filter.applied = value
    @updateUrl()
    @fetchResults()

  handleFilterAdded: (filter) ->
    @changeFilterValue(filter, true)

  handleFilterRemove: (filter) ->
    @changeFilterValue(filter, false)

  handleLoad: (search, statusCode, xhr) ->
    @setState(search: search, step: 'results')

  handleLoadFilters: (data) ->
    @state.search.filters = data.filters
    @forceUpdate()

  handleError: (xhr, statusCode, statusText) ->
    console.log("error", xhr, statusCode, statusText)
    flash('error', 'Opps, could not load data. Check your internet connection.')

  render: ->
    results =
      if @state.step == 'searching'
        <div className="result-box">
          <Loader loaded={@state.step == 'results'} />
        </div>
      else if @state.step == 'results'
        <ResultBox sortBy={@state.search.sort_by} results={@state.search.results} onSortChange={@handleSortChange} />

    <div className="search-page">
      <SearchBox
        search={@state.search}
        onSearch={@handleSearch}
        onAddFilter={@handleFilterAdded}
        onRemoveFilter={@handleFilterRemove}
        onShowMenu={@props.onShowMenu}
      />
      {results}
    </div>
