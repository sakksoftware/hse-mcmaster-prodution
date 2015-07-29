module.exports = React.createClass
  displayName: 'MenuToggle'
  propTypes:
    menu: React.PropTypes.string.isRequired
    onToggle: React.PropTypes.func.isRequired
    children: React.PropTypes.node

  handleClick: (e) ->
    e.stopPropagation() # prevent things like dismiss menu from being called on parent
    @props.onToggle(@props.menu)

  render: ->
    <button ref="btnOffcanvas" type="button" onClick={@handleClick} className={"toggle-#{@props.menu}-menu"}>
      <span className="sr-only">Toggle navigation</span>
      {@props.children}
    </button>