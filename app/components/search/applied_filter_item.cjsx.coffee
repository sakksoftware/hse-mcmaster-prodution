FilterNormalizationService = require('services/filter_normalization_service')

module.exports = React.createClass
  displayName: 'AppliedFiltersItem'
  mixins: [FilterNormalizationService]
  propTypes:
    filter: React.PropTypes.object.isRequired
    onRemoveFilter: React.PropTypes.func.isRequired

  getChildFiltersText: ->
    _(@getFiltersArray(@props.filter.filters)).pluck('title').join(', ').substring(0, 30)

  getFilterText: ->
    "#{@props.filter.title}: #{@getChildFiltersText()}"

  handleRemove: (e) ->
    e.preventDefault()
    @props.onRemoveFilter(@props.filter)

  render: ->
    <li className="applied-filter-item">
      {@getFilterText()}
      <a href="#" className="applied-filter-item-remove" onClick={@handleRemove}>x</a>
    </li>
