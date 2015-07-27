AppliedFilters = require('components/search/applied_filters')
FilterBox = require('components/search/filter_box')
SearchBar = require('components/search/search_bar')
MenuToggle = require('components/menus/menu_toggle')

module.exports = React.createClass
  displayName: 'SearchBox'
  propTypes:
    search: React.PropTypes.object
    onSearch: React.PropTypes.func.isRequired
    onAddFilter: React.PropTypes.func.isRequired
    onRemoveFilter: React.PropTypes.func.isRequired
    onShowHelp: React.PropTypes.func.isRequired

  getAppliedFilters: ->
    @props.search.filters.filter((e) => e.applied)

  render: ->
    filterBox =
      if @props.search.questions?.length > 0
        <FilterBox guideQuestions={@props.search.questions} onAddFilter={@props.onAddFilter} />
    appliedFilters =
      if @props.search.filters?.length > 0
        <AppliedFilters filters={@getAppliedFilters()} onRemoveFilter={@props.onRemoveFilter} />

    <div className="search-box">
      <SearchBar query={@props.search.query} onSearch={@props.onSearch} />
      <MenuToggle menu="help" onToggle={@props.onShowHelp}>
        <span className="icon"></span>Tips for more powerful serach
      </MenuToggle>
      <hr />
      {filterBox}
    </div>