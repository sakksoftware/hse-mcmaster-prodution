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
        borderColor: @props.indicatorColor
        borderLeftWidth: "4px"
        borderLeftStyle: "solid"

    <li className="menu-item menu-filter-item" style={style}>
      <a href="#" onClick={@handleToggle}>{filter.name}</a>
      {@renderCheckMark(filter)}
    </li>
