FilterNormalizationService = require('services/filter_normalization_service')

module.exports = React.createClass
  displayName: 'AppliedFiltersItem'
  mixins: [FilterNormalizationService]
  propTypes:
    filter: React.PropTypes.object.isRequired
    onRemoveFilter: React.PropTypes.func.isRequired

  getChildFiltersText: ->
    _(@getFiltersArray(@props.filter.filters)).pluck('title').join(', ').substring(0, 30)

  handleRemove: (e) ->
    e.preventDefault()
    @props.onRemoveFilter(@props.filter)

  render: ->
    <li className="applied-filter-item">
      <div className="applied-filter-item-content">
        <span className="applied-filter-item-section">{"#{@props.filter.title}:"}</span>
        <span className="applied-filter-item-filters">{@getChildFiltersText()}</span>
      </div>
      <a href="#" className="applied-filter-item-remove" onClick={@handleRemove}>x</a>
    </li>
