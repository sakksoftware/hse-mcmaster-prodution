Button = ReactBootstrap.Button
SearchActions = require('actions/search_actions')
SearchHeader = require('components/search/search_header')
SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')

module.exports = React.createClass
  displayName: 'App'
  getInitialState: ->
    search:
      query: ''
      sort_by: 'relevance'
      results: null
      filters: null

  fetchResults: ->
    SearchActions.search @state.search.query,
      @handleLoad,
      @handleError,
        sortBy: @state.search.sort_by,
        filters: @state.search.filters?.filter((e) -> e.applied) || []

  handleSearch: (query) ->
    @state.search.query = query
    @fetchResults()

  handleSortChange: (sortBy) ->
    @state.search.sort_by = sortBy
    @fetchResults()

  changeFilterValue: (filter, value) ->
    filter = _(@state.search.filters).find (f) -> f.id == filter.id
    filter.applied = value
    @fetchResults()

  handleFilterAdded: (filter) ->
    @changeFilterValue(filter, true)

  handleFilterRemove: (filter) ->
    @changeFilterValue(filter, false)

  handleLoad: (search, statusCode, xhr) ->
    @setState(search: search)

  handleError: (xhr, statusCode, statusText) ->
    console.log("error", xhr, statusCode, statusText)

  render: ->
    results =
      if @state.search.results != null
        <ResultBox sortBy={@state.search.sort_by} results={@state.search.results} onSortChange={@handleSortChange} />

    <div id="app">
      <SearchHeader />
      <SearchBox search={@state.search} onSearch={@handleSearch} onAddFilter={@handleFilterAdded} onRemoveFilter={@handleFilterRemove} />
      {results}
    </div>
