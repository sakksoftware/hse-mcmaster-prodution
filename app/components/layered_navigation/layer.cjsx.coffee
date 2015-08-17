module.exports = React.createClass
  displayName: 'Layer'
  propTypes:
    # TODO: all are required but, there a problem since we over-write the layer
    # think of another appraoch... Layer vs ConcreteLayer?
    onClose: React.PropTypes.func
    title: React.PropTypes.string
    level: React.PropTypes.number
    name: React.PropTypes.string
    contentOverlay: React.PropTypes.string
    children: React.PropTypes.node.isRequired

  handleClose: (e) ->
    e.preventDefault()
    @props.onClose()

  render: ->
    baseZIndex = 1000
    # TODO: get layer width from css
    layerWidth = 288
    levelOffset = 8
    layerPadding = 16
    closeButtonWidth = 16

    width = layerWidth
    offset = @props.level * levelOffset
    style = {}
    if offset != 0
      width = layerWidth - offset + levelOffset
      style =
        "borderLeft": "#{levelOffset}px solid rgba(0, 0, 0, 0.2)"
        "width": "#{width}px"
        "zIndex": baseZIndex + @props.level

    titleWidth = width - (layerPadding * 2.5 + closeButtonWidth + levelOffset)

    <nav className="layer layer-#{@props.name}" role="navigation" style={style}>
      <div className="layer-header">
        <span className="layer-header-title" style={width: "#{titleWidth}px"}>{@props.title || "Menu"}</span>
        <a className="layer-header-close" href="#" onClick={@handleClose}>x</a>
      </div>
      <div className="layer-inner">
        <div className="layer-content">
          {@props.children}
        </div>
      </div>
    </nav>
