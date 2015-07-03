module.exports = React.createClass
  displayName: 'AppliedFiltersItem'
  propTypes:
    filter: React.PropTypes.object.isRequired
    onRemoveFilter: React.PropTypes.func.isRequired

  handleRemove: (e) ->
    e.preventDefault()
    @props.onRemoveFilter(@props.filter)

  render: ->
    <li className="applied-filter-item">
      <a href="#" className="applied-filter-item-remove" onClick={@handleRemove}>x</a>
      {@props.filter.name}
    </li>