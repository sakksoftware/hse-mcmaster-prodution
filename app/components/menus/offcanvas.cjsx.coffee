Sidebar = require('components/menus/sidebar')
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  propTypes:
    children: React.PropTypes.node.isRequired

  getInitialState: ->
    menus: []

  toggleMenu: (menuName, menuContext = {}) ->
    menus = _.clone(@state.menus)
    return if _.find(menus, (menu) -> menu.name == menuName)

    # move focus away from button used to bring up the menu
    document.activeElement.blur()

    menus.push({name: menuName, context: menuContext})
    @setState(menus: menus, currentUser: @state.currentUser)

  dismissMenu: ->
    menus = _.clone(@state.menus)
    menus.pop()
    @setState(menus: menus, currentUser: @state.currentUser)
    return # avoid warning message from react by return undefined

  findSidebarGroup: ->
    _.find @props.children, (sidebar) =>
      sidebar.type.displayName == "SidebarGroup"

  findMenu: (menuName) ->
    menu = _.find @findSidebarGroup().props.children, (menu) =>
      menu.type.displayName == "Sidebar" and menu.props.name == menuName

    unless menu
      throw new Error("Unknown menu requested #{menuName}")

    [menu.props.children, menu.props.title]

  renderSidebar: (content, title, level) ->
    <Sidebar key="sidebar-#{level + 1}" onClose={@dismissMenu} title={title} level={level}>
      {content}
    </Sidebar>

  renderSidebars: ->
    menus = @state.menus
    level = -1
    for menu in menus
      level += 1
      [content, title] = @findMenu(menu.name)
      @renderSidebar(content, title, level)

  render: ->
    className = "app"
    className += " menu-toggled" if @state.menus.length > 0
    <div className={className} id="app">
      <ReactCSSTransitionGroup transitionName="sidebar"  component="div">
        {@renderSidebars()}
      </ReactCSSTransitionGroup>
      <div id="page-content-wrapper" onClick={@dismissMenu}>
        {@props.children}
      </div>
    </div>
