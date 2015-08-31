AppliedFilterItem = require('components/search/applied_filter_item')
SearchStore = require('stores/search_store')

module.exports = React.createClass
  displayName: 'AppliedFilters'
  propTypes:
    filters: React.PropTypes.array.isRequired
    onRemoveFilter: React.PropTypes.func.isRequired
    onShowFilterGroup: React.PropTypes.func.isRequired

  onShowFilterGroup: (section, filter) ->
    filter = SearchStore.findFilter(filter)
    @props.onShowFilterGroup(section, filter)

  onRemoveFilter: (filter) ->
    @props.onRemoveFilter(filter)

  getAppliedFilterGroups: (filters) ->
    SearchStore.getAppliedFilterGroups()

  renderFilters: ->
    for filterSection, i in @getAppliedFilterGroups()
      for filterGroup, j in filterSection.filters
        <AppliedFilterItem section={filterSection} filter={filterGroup} key="filter-#{filterGroup.id}"
          onShowFilterGroup={@onShowFilterGroup}
          onRemoveFilter={@onRemoveFilter} />

  render: ->
    <ul className="applied-filters">
      {@renderFilters()}
    </ul>
