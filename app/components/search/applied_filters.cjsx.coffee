AppliedFilterItem = require('components/search/applied_filter_item')

module.exports = React.createClass
  displayName: 'AppliedFilters'
  propTypes:
    filters: React.PropTypes.array.isRequired
    onRemoveFilter: React.PropTypes.func.isRequired

  renderFilters: ->
    for filter, index in @props.filters
      <AppliedFilterItem filter={filter} key="filter-#{index}" onRemoveFilter={@props.onRemoveFilter} />

  render: ->
    <ul className="applied-filters">
      {@renderFilters()}
    </ul>