Button = ReactBootstrap.Button
FilterActions = require('actions/filter_actions')
SearchActions = require('actions/search_actions')
SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')
FilterNormalizationService = require('services/filter_normalization_service')
Url = require('lib/url')

module.exports = React.createClass
  displayName: 'SearchPage'

  mixins: [FilterNormalizationService]

  propTypes:
    onShowHelp: React.PropTypes.func.isRequired
    onShowFilters: React.PropTypes.func.isRequired

  # steps
  # pending_search
  # searching
  # results
  getInitialState: ->
    params = Url.params()
    applied_filters = params.applied_filters?.split(';')
    # set applied filters until we fetch filers from search
    filters = applied_filters?.map (f) -> id: parseInt(f, 10), applied: true
    search:
      query: if params.q? then params.q else null
      sort_by: params.sort_by || 'relevance'
      results: null
      applied_filters: applied_filters || null
      filters: filters || []
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
    SearchActions.search @state.search.query,
      @handleLoad,
      @handleError,
        sortBy: @state.search.sort_by,
        applied_filters: @getAppliedFilters() || []

  getAppliedFilters: ->
    filters = @getFiltersArray(@state.search.filters)
    filters.filter((e) -> e.applied)

  updateUrl: ->
    query = @state.search.query || ""
    applied_filters = @getAppliedFilters() || []
    applied_filters = _(applied_filters).pluck('id').join(";")
    sortBy = @state.search.sort_by || ""
    Router = require('lib/router')
    Router.update("?q=#{query}&sort_by=#{sortBy}&applied_filters=#{applied_filters}")

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
        onShowHelp={@props.onShowHelp}
        onShowFilters={@props.onShowFilters}
      />
      {results}
    </div>
