module.exports = React.createClass
  displayName: 'Sidebar'
  propTypes:
    onClose: React.PropTypes.func.isRequired
    title: React.PropTypes.string
    level: React.PropTypes.number
    children: React.PropTypes.node.isRequired

  handleClose: (e) ->
    e.preventDefault()
    @props.onClose()

  render: ->
    baseZIndex = 1000
    sidebarWidth = 250
    levelOffset = 20
    offset = @props.level * levelOffset
    style = {}
    if offset != 0
      style =
        "borderLeft": "#{levelOffset}px solid rgba(0, 0, 0, 0.2)"
        "width": "#{sidebarWidth - offset + levelOffset}px"
        "zIndex": baseZIndex + @props.level

    <nav className="sidebar-wrapper" role="navigation" style={style}>
      <div className="sidebar">
        <div className="sidebar-header">
          <span className="sidebar-header-title">{@props.title || "Menu"}</span>
          <a className="sidebar-header-close" href="#" onClick={@handleClose}>x</a>
        </div>
        <div className="sidebar-content">
          {@props.children}
        </div>
      </div>
    </nav>
