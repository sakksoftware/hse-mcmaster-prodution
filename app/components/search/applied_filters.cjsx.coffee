AppliedFilterItem = require('components/search/applied_filter_item')

module.exports = React.createClass
  displayName: 'AppliedFilters'
  propTypes:
    filters: React.PropTypes.array.isRequired
    onRemoveFilter: React.PropTypes.func.isRequired
    onShowFilterGroup: React.PropTypes.func.isRequired

  findFirstApplied: (filters)->
    _.find filters, (f) =>
      return true if f.applied
      if f.filters
        return @findFirstApplied(f.filters)

      return false

  onShowFilterGroup: (filter) ->
    filter = _.find @props.filters, (f) -> f.id == filter.id
    @props.onShowFilterGroup(filter, @findFirstApplied(filter.filters))

  onRemoveFilter: (filter) ->
    filter = _.find @props.filters, (f) -> f.id == filter.id
    @props.onRemoveFilter(filter)
    @forceUpdate()

  getAppliedFilterGroups: (filters) ->
    appliedFilters = []

    for filter in filters
      filter = _.clone(filter)

      if filter.filters
        filter.filters = @getAppliedFilterGroups(filter.filters)

      if filter.applied || filter.filters?.length > 0
        appliedFilters.push filter

    appliedFilters

  renderFilters: ->
    for filter, index in @getAppliedFilterGroups(@props.filters)
      <AppliedFilterItem filter={filter} key="filter-#{index}"
        onShowFilterGroup={@onShowFilterGroup}
        onRemoveFilter={@onRemoveFilter} />

  render: ->
    <ul className="applied-filters">
      {@renderFilters()}
    </ul>
