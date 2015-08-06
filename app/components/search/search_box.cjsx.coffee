AppliedFilters = require('components/search/applied_filters')
FilterBox = require('components/search/filter_box')
SearchBar = require('components/search/search_bar')
MenuToggle = require('components/menus/menu_toggle')
FilterNormalizationService = require('services/filter_normalization_service')

module.exports = React.createClass
  displayName: 'SearchBox'
  mixins: [FilterNormalizationService]
  propTypes:
    search: React.PropTypes.object
    onSearch: React.PropTypes.func.isRequired
    onAddFilter: React.PropTypes.func.isRequired
    onRemoveFilter: React.PropTypes.func.isRequired
    onShowHelp: React.PropTypes.func.isRequired

  getAppliedFilters: ->
    filters = @getFiltersArray(@props.search.filters || [])
    filters.filter((e) => e.applied)

  handleFilterToggle: (filter) ->
    if filter.applied
      @props.onRemoveFilter(filter)
    else
      @props.onAddFilter(filter)

  renderFilterCount: ->
    count = @getAppliedFilters()?.length || 0
    if count > 0
      <span className="badge">{count}</span>

  render: ->
    filterBox =
      if @props.search.questions?.length > 0
        <FilterBox guideQuestions={@props.search.questions} onAddFilter={@props.onAddFilter} />

    <div className="search-box">
      <SearchBar query={@props.search.query} onSearch={@props.onSearch} />
      <div className="menu-toggles">
        <MenuToggle menu="help" onToggle={@props.onShowHelp}>
          <span className="icon"></span>Tips for more powerful serach
        </MenuToggle>
        <MenuToggle
          menu="filterGroups"
          context={filters: @props.search.filters, onToggleFilter: @handleFilterToggle}
          onToggle={@props.onShowFilters}>
          Filters
          {@renderFilterCount()}
        </MenuToggle>
      </div>
      {filterBox}
    </div>
