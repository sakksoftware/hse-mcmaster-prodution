module.exports = React.createClass
  displayName: 'MenuToggle'
  propTypes:
    menu: React.PropTypes.string.isRequired
    context: React.PropTypes.any
    onToggle: React.PropTypes.func.isRequired
    children: React.PropTypes.node

  handleClick: (e) ->
    e.stopPropagation() # prevent things like dismiss menu from being called on parent
    @props.onToggle(@props.menu, @props.context)

  render: ->
    menu = @props.menu.replace(/([A-Z])/g, "-$1").toLowerCase()
    <button ref="btnOffcanvas" type="button" onClick={@handleClick} className={"menu-toggle menu-toggle-#{menu}"}>
      <span className="sr-only">Toggle navigation</span>
      {@props.children}
    </button>
