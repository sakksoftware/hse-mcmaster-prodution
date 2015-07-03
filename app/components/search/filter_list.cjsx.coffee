FilterItem = require('components/search/filter_item')

module.exports = React.createClass
  displayName: 'FilterList'
  propTypes:
    filters: React.PropTypes.array.isRequired
    onAddFilter: React.PropTypes.func.isRequired

  renderFilters: ->
    for filter, i in @props.filters
      <FilterItem key={"filter-#{i}"} filter={filter} onAddFilter={@props.onAddFilter} />

  render: ->
    <ul className="filter-list">
      {@renderFilters()}
    </ul>