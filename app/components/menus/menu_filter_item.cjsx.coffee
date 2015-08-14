module.exports = React.createClass
  displayName: 'MenuFilterItem'
  propTypes:
    filter: React.PropTypes.object.isRequired
    onToggle: React.PropTypes.func.isRequired
    indicatorColor: React.PropTypes.string

  handleToggle: (e) ->
    e.preventDefault()
    @props.onToggle(@props.filter)

  renderCheckMark: (filter) ->
    if filter.applied
      <i className="checkmark"></i>

  render: ->
    filter = @props.filter
    style = {}
    if @props.indicatorColor
      style =
        "border-color": @props.indicatorColor
        "border-left-width": "4px"
        "border-left-style": "solid"

    <li className="menu-item menu-filter-item" style={style}>
      <a href="#" onClick={@handleToggle}>{filter.name}</a>
      {@renderCheckMark(filter)}
    </li>
