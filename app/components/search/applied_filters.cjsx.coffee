AppliedFilterItem = require('components/search/applied_filter_item')

module.exports = React.createClass
  displayName: 'AppliedFilters'
  propTypes:
    filters: React.PropTypes.array.isRequired

  renderFilters: ->
    for filter, index in @props.filters
      <AppliedFilterItem filter={filter} key="filter-#{index}" />

  render: ->
    <ul className="applied-filters">
      {@renderFilters()}
    </ul>