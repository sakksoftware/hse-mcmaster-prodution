module.exports = React.createClass
  displayName: 'MenuToggle'
  propTypes:
    menu: React.PropTypes.string.isRequired
    onToggle: React.PropTypes.func.isRequired
    children: React.PropTypes.node

  render: ->
    <button ref="btnOffcanvas" type="button" onClick={=> @props.onToggle(@props.menu)} className={"toggle-#{@props.menu}-menu"}>
      <span className="sr-only">Toggle navigation</span>
      {@props.children}
    </button>