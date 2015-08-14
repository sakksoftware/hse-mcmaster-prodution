module.exports = React.createClass
  displayName: 'MenuFilterItem'
  propTypes:
    filter: React.PropTypes.object.isRequired
    onToggle: React.PropTypes.func.isRequired

  handleToggle: (e) ->
    e.preventDefault()
    @props.onToggle(@props.filter)

  renderCheckMark: (filter) ->
    if filter.applied
      <i className="checkmark"></i>

  render: ->
    filter = @props.filter
    <li className="menu-item menu-filter-item">
      <a href="#" onClick={@handleToggle}>{filter.name}</a>
      {@renderCheckMark(filter)}
    </li>
