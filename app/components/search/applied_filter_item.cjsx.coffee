module.exports = React.createClass
  displayName: 'AppliedFiltersItem'
  propTypes:
    filter: React.PropTypes.object.isRequired

  render: ->
    <li className="applied-filter-item">{@props.filter.name}</li>