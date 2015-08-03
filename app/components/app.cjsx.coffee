SearchPage = require('components/search/search_page')
DocumentPage = require('components/documents/document_page')

Sidebar = require('components/menus/sidebar')
MenuToggle = require('components/menus/menu_toggle')
MainMenu = require('components/menus/main_menu')
DesktopMainMenu = require('components/menus/desktop_main_menu')
HelpMenu = require('components/menus/help_menu')
FiltersMenu = require('components/menus/filters_menu')
CountriesMenu = require('components/menus/countries_menu')

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: 'App'

  propTypes:
    page: React.PropTypes.string.isRequired

  getInitialState: ->
    menus: []

  toggleMenu: (menuName, menuContext = {}) ->
    menus = _.clone(@state.menus)
    return if _.find(menus, (menu) -> menu.name == menuName)

    # move focus away from button used to bring up the menu
    document.activeElement.blur()

    menus.push({name: menuName, context: menuContext})
    @setState(menus: menus)

  dismissMenu: ->
    menus = _.clone(@state.menus)
    menus.pop()
    @setState(menus: menus)
    return # avoid warning message from react by return undefined

  renderHeader: ->
    <nav className="top-nav">
      <h1>Health System Evidence</h1>
      <MenuToggle menu="main" onToggle={@toggleMenu}>
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
      </MenuToggle>
      <DesktopMainMenu />
    </nav>

  renderPage: ->
    # TODO: can be generalized by invoking the right factory based on page name passed in
    # and passing the arguments
    switch @props.page
      when 'SearchPage'
        <SearchPage key="search-page" onShowHelp={@toggleMenu} onShowFilters={@toggleMenu} />
      when 'DocumentPage'
        id = @props.args.id
        <DocumentPage id={id} key={"document-page-#{id}"} />
      else
        throw new Error("Page not found! Please check the URL")

  renderSidebar: (content, title, level) ->
    <Sidebar key="sidebar-#{level + 1}" onClose={@dismissMenu} title={title} level={level}>
      {content}
    </Sidebar>

  renderSidebars: ->
    menus = @state.menus
    level = -1
    for menu in menus
      level += 1
      switch menu.name
        when 'main'
          title = "Menu"
          @renderSidebar(<MainMenu />, title, level)
        when 'help'
          title = "Help"
          @renderSidebar(<HelpMenu />, title, level)
        when 'filters'
          title = "Filter documents by..."
          @renderSidebar(<FiltersMenu filters={menu.context.filters} onFilterClick={@toggleMenu} />, title, level)
        when 'countries'
          title = "Countries"
          @renderSidebar(<CountriesMenu countries={menu.context.countries} onToggleCountry={@toggleCountry} />, title, level)
        else
          throw new Error("Unknown menu requested")

  render: ->
    className = "app"
    className += " menu-toggled" if @state.menus.length > 0
    # TODO: in order to generalize the menu toggle the proper way is the wrap the whole application
    # with a menu toggle component. Think of UIScrollbar and how things work in iOS, it is the same concept for
    # off canvas. It is similar to a master-view layout.
    <div className={className} id="app">
      <ReactCSSTransitionGroup transitionName="sidebar"  component="div">
        {@renderSidebars()}
      </ReactCSSTransitionGroup>
      <div id="page-content-wrapper" onClick={@dismissMenu}>
        {@renderHeader()}
        <div id="page-content">
          <ReactCSSTransitionGroup transitionName="page" component="div">
            {@renderPage()}
          </ReactCSSTransitionGroup>
        </div>
      </div>
    </div>
