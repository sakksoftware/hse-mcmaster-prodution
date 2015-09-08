Layer = require('components/layered_navigation/layer')
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: "LayeredNavigation"
  propTypes:
    id: React.PropTypes.string
    className: React.PropTypes.string
    children: React.PropTypes.node.isRequired

  getDefaultProps: ->
    className: ''

  getInitialState: ->
    menus: []

  toggleMenu: (menuName, title, menuContext) ->
    menuContext = title unless menuContext

    menus = _.clone(@state.menus)
    return if _.find(menus, (menu) -> menu.name == menuName)

    # move focus away from button used to bring up the menu
    document.activeElement.blur()

    menus.push({name: menuName, title: title, context: menuContext})
    @setState(menus: menus)

  dismissMenu: ->
    return if @state.menus.length == 0

    menus = _.clone(@state.menus)
    menu = menus.pop()
    menu.context?.onDismiss?()
    @setState(menus: menus)
    return # avoid warning message from react by return undefined

  findLayerGroup: ->
    _.find @props.children, (child) =>
      child.type.displayName == "LayerGroup"

  findMenu: (menuName) ->
    menu = _.find @findLayerGroup().props.children, (menu) =>
      menu.type.displayName == "Layer" and menu.props.name == menuName

    unless menu
      throw new Error("Unknown menu requested #{menuName}")

    [menu.props.children, menu.props.title]

  setOverlayContent: (content) ->
    @setState(overlayContent: content)

  renderOverlayContent: ->
    if @state.menus.length > 0 && @state.overlayContent
      <div className="layered-navigation-overlay-content">
        {@state.overlayContent}
      </div>

  renderLayer: (name, content, title, level) ->
    <Layer key="layer-#{level + 1}" onClose={@dismissMenu} name={name} title={title} level={level}>
      {content}
    </Layer>

  renderLayers: ->
    menus = @state.menus
    level = -1
    for menu in menus
      level += 1
      [content, title] = @findMenu(menu.name)
      title = menu.title if menu.title

      props = _.clone(content.props)
      props.context = menu.context

      content = React.cloneElement(content, props)

      @renderLayer(menu.name, content, title, level)

  render: ->
    className = @props.className + " layered-navigation"
    className += " layer-toggled" if @state.menus.length > 0

    <div id={@props.id} className={className}>
      <ReactCSSTransitionGroup transitionName="layer" component="div">
        {@renderLayers()}
      </ReactCSSTransitionGroup>
      <div className="layered-navigation-content">
        <div className="layered-navigation-overlay" onClick={@dismissMenu}>{@renderOverlayContent()}</div>
        {@props.children}
      </div>
    </div>
