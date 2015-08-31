FilterNormalizationService = require('services/filter_normalization_service')

module.exports = React.createClass
  displayName: 'AppliedFiltersItem'
  mixins: [FilterNormalizationService]
  propTypes:
    filter: React.PropTypes.object.isRequired
    section: React.PropTypes.object.isRequired
    onRemoveFilter: React.PropTypes.func.isRequired
    onShowFilterGroup: React.PropTypes.func.isRequired

  getChildFiltersText: ->
    _(@getFiltersArray(@props.filter.filters)).pluck('title').join(', ').substring(0, 50)

  handleShowFilterGroup: (e) ->
    e.preventDefault()
    @props.onShowFilterGroup(@props.section, @props.filter)

  handleRemove: (e) ->
    e.preventDefault()
    @props.onRemoveFilter(@props.filter)

  render: ->
    <li className="applied-filter-item">
      <a className="applied-filter-item-content" href="#" onClick={@handleShowFilterGroup}>
        <span className="applied-filter-item-filters">{@getChildFiltersText()}</span>
      </a>
      <a href="#" className="applied-filter-item-remove" onClick={@handleRemove}>x</a>
    </li>
