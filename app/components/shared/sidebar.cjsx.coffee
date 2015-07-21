module.exports = React.createClass
  displayName: 'Sidebar'
  propTypes:
    onClose: React.PropTypes.func.isRequired
    title: React.PropTypes.string
    children: React.PropTypes.node.isRequired

  handleClose: (e) ->
    e.preventDefault()
    @props.onClose()

  render: ->
    <nav id="sidebar-wrapper" role="navigation">
      <div className="sidebar">
        <div className="sidebar-header">
          <span className="sidebar-header-title">{@props.title || "Menu"}</span>
          <a className="sidebar-header-close" href="#" onClick={@handleClose}>x</a>
        </div>
        {@props.children}
      </div>
    </nav>