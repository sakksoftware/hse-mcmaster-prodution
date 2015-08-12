module.exports = React.createClass
  displayName: 'Layer'
  propTypes:
    onClose: React.PropTypes.func
    title: React.PropTypes.string
    level: React.PropTypes.number
    children: React.PropTypes.node.isRequired

  handleClose: (e) ->
    e.preventDefault()
    @props.onClose()

  render: ->
    baseZIndex = 1000
    layerWidth = 250
    levelOffset = 20
    offset = @props.level * levelOffset
    style = {}
    if offset != 0
      style =
        "borderLeft": "#{levelOffset}px solid rgba(0, 0, 0, 0.2)"
        "width": "#{layerWidth - offset + levelOffset}px"
        "zIndex": baseZIndex + @props.level

    <nav className="layer" role="navigation" style={style}>
      <div className="layer-inner">
        <div className="layer-header">
          <span className="layer-header-title">{@props.title || "Menu"}</span>
          <a className="layer-header-close" href="#" onClick={@handleClose}>x</a>
        </div>
        <div className="layer-content">
          {@props.children}
        </div>
      </div>
    </nav>
