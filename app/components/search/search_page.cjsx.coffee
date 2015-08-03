Button = ReactBootstrap.Button
SearchActions = require('actions/search_actions')
SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')
Url = require('lib/url')

module.exports = React.createClass
  displayName: 'SearchPage'

  propTypes:
    onShowHelp: React.PropTypes.func.isRequired
    onShowFilters: React.PropTypes.func.isRequired

  # steps
  # pending_search
  # searching
  # results
  getInitialState: ->
    params = Url.params()
    search:
      query: params.q || ''
      sort_by: params.sort_by || 'relevance'
      results: null
      applied_filters: params.applied_filters?.split(';') || null
      filters: null
    step: 'pending_search'

  componentWillMount: ->
    # TODO: remove when passing results as an attribute from server a bit hacky now
    @fetchResults() unless _.isEmpty(@state.search.query)

  fetchResults: ->
    @setState(step: 'searching', search: @state.search)
    SearchActions.search @state.search.query,
      @handleLoad,
      @handleError,
        sortBy: @state.search.sort_by,
        applied_filters: @getAppliedFilters() || []

  getAppliedFilters: ->
    @state.search.filters?.filter((e) -> e.applied)

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
    filter = _(@state.search.filters).find (f) -> f.id == filter.id
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
