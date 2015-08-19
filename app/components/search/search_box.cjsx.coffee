AppliedFilters = require('components/search/applied_filters')
FilterBox = require('components/search/filter_box')
SearchBar = require('components/search/search_bar')
LayerToggle = require('components/layered_navigation/layer_toggle')
FilterNormalizationService = require('services/filter_normalization_service')

module.exports = React.createClass
  displayName: 'SearchBox'
  mixins: [FilterNormalizationService]
  propTypes:
    search: React.PropTypes.object
    onSearch: React.PropTypes.func.isRequired
    onToggleFilter: React.PropTypes.func.isRequired
    onAddFilter: React.PropTypes.func.isRequired
    onShowMenu: React.PropTypes.func.isRequired
    overlayContent: React.PropTypes.string

  getInitialState: ->
    showingFiltersMenu: false

  getAppliedFilters: ->
    filters = @getFiltersArray(@props.search.filters || [])
    filters = filters.filter((e) => e.applied)

    # delete coutnries filter fro
    filters = _.reject filters, (f) -> f.type == "countries"
    filters

  handleClickFiltersButton: ->
    @props.onShowMenu.apply(@, arguments)
    @setState(showingFiltersMenu: true)

  handleBackToSearchResults: (ev) ->
    ev.preventDefault()
    @props.dismissMenu()

  renderFilterCount: ->
    count = @getAppliedFilters()?.length || 0
    if count > 0
      <span className="filter-count">{count}</span>

  renderResultCountFooter: ->
    if @state.showingFiltersMenu && @props.search?.results_count
      <div className="result-count">
        <a href="#" onClick={@handleBackToSearchResults}>View {@props.search.results_count} results</a>
      </div>

  render: ->
    filterBox =
      if @props.search.questions?.length > 0
        <FilterBox guideQuestions={@props.search.questions} onAddFilter={@props.onAddFilter} />

    <div className="search-box">
      <SearchBar query={@props.search.query} onSearch={@props.onSearch} />
      <div className="layer-toggles">
        <LayerToggle menu="help" onToggle={@props.onShowMenu}>
          <span className="icon"></span>Tips for more powerful serach
        </LayerToggle>
        <LayerToggle
          menu="filterGroups"
          context={
            filters: @props.search.filters
            onShowFilterGroup: @props.onShowMenu
            onToggleFilter: @props.onToggleFilter
            overlayContent: @props.overlayContent
          }
          onToggle={@handleClickFiltersButton}
        >
          Filters
          {@renderFilterCount()}
        </LayerToggle>
      </div>
      {filterBox}
      {@renderResultCountFooter()}
    </div>
