SearchPage = require('components/search/search_page')
DocumentPage = require('components/documents/document_page')

Sidebar = require('components/menus/sidebar')
MenuToggle = require('components/menus/menu_toggle')
MainMenu = require('components/menus/main_menu')
HelpMenu = require('components/menus/help_menu')
FiltersMenu = require('components/menus/filters_menu')
CountriesMenu = require('components/menus/countries_menu')

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: 'App'

  propTypes:
    page: React.PropTypes.string.isRequired

  getInitialState: ->
    menuToggled: false
    menuName: 'main'

  toggleMenu: (menuName) ->
    @setState(menuToggled: !@state.menuToggled, menuName: menuName)

  dismissMenu: ->
    @state.menuToggled && @toggleMenu(@state.menuName)
    return # avoid warning message from react by return undefined

  renderHeader: ->
    <nav className="top-nav">
      <h1>Health System Evidence</h1>
      <MenuToggle menu="main" onToggle={@toggleMenu}>
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
      </MenuToggle>
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

  renderSidebar: ->
    switch @state.menuName
      when 'main'
        title = "Menu"
        content = <MainMenu />
      when 'help'
        title = "Help"
        content = <HelpMenu />
      when 'filters'
        title = "Filter documents by..."
        content = <FiltersMenu onFilterClick={@toggleMenu} />
      when 'countries'
        title = "Countries"
        content = <CountriesMenu />
      else
        throw new Error("Unknown menu requested!")

    <Sidebar onClose={@dismissMenu} title={title}>
      {content}
    </Sidebar>

  render: ->
    className = "app #{@state.menuToggled && ('menu-toggled' || '')}"
    <div className={className} id="app">
      {@renderSidebar()}
      <div id="page-content-wrapper" onClick={@dismissMenu}>
        {@renderHeader()}
        <div id="page-content">
          <ReactCSSTransitionGroup transitionName="page" component="div">
            {@renderPage()}
          </ReactCSSTransitionGroup>
        </div>
      </div>
    </div>