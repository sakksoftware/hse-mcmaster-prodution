Button = ReactBootstrap.Button
FilterActions = require('actions/filter_actions')
SearchActions = require('actions/search_actions')
SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')
FilterNormalizationService = require('services/filter_normalization_service')
SearchSerializationService = require('services/search_serialization_service')
SearchDeserializationService = require('services/search_deserialization_service')
FilterGroupsMenu = require('components/menus/filter_groups_menu')

module.exports = React.createClass
  displayName: 'SearchPage'

  mixins: [FilterNormalizationService, SearchSerializationService, SearchDeserializationService]

  propTypes:
    onShowMenu: React.PropTypes.func.isRequired
    dismissMenu: React.PropTypes.func.isRequired

  # steps
  # pending_search
  # searching
  # results
  getInitialState: ->
    search: @deserializeSearchUrl()
    filtersLoaded: false
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

  handleFilterToggle: (filter) ->
    if filter.applied
      @handleFilterRemove(filter)
    else
      @handleFilterAdded(filter)

  handleFilterAdded: (filter) ->
    @changeFilterValue(filter, true)

  handleFilterRemove: (filter) ->
    @changeFilterValue(filter, false)

  handleLoad: (search, statusCode, xhr) ->
    @setState(search: search, step: 'results', filtersLoaded: true)

  handleLoadFilters: (data) ->
    @state.search.filters = data.filters
    @setState(search: @state.search, step: @state.step, filtersLoaded: true)
    @forceUpdate()

  handleError: (xhr, statusCode, statusText) ->
    console.log("error", xhr, statusCode, statusText)
    flash('error', 'Opps, could not load data. Check your internet connection.')

  getOverylayContent: ->
    if @props.search?.results_count
      "#{@props.search.results_count} results"

  renderDesktopFiltersMenu: ->
    if @state.filtersLoaded
      <div className="filter-groups-menu-wrapper">
        <div className="filter-groups-menu-title">
          Filter documents by...
        </div>
        <FilterGroupsMenu context={
          filters: @state.search.filters
          onToggleFilter: @handleFilterToggle
          onShowFilterGroup: @props.onShowMenu
          overlayContent: @getOverylayContent()
        } />
      </div>

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
        onToggleFilter={@handleFilterToggle}
        onAddFilter={@handleFilterAdded}
        onShowMenu={@props.onShowMenu}
        dismissMenu={@props.dismissMenu}
        overlayContent={@getOverylayContent()}
      />
      {@renderDesktopFiltersMenu()}
      {results}
    </div>
