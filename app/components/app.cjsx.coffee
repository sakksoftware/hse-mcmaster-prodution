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
    menus: ['main']

  toggleMenu: (menuName) ->
    menus = _.clone(@state.menus)
    menus.push(menuName) if _.last(menus) != menuName
    console.log("menus:", menus)
    @setState(menus: menus)

  dismissMenu: ->
    # TODO: reimplement dismiss
    menus = _.clone(@state.menus)
    menus.pop()
    console.log("menus:", menus)
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

  renderSidebar: (content, title) ->
    <Sidebar onClose={@dismissMenu} title={title}>
      {content}
    </Sidebar>

  renderSidebars: ->
    menus = @state.menus
    sidebars = []
    if menus.indexOf('main') >= 0
      title = "Menu"
      sidebars.push @renderSidebar(<MainMenu />, title)
    if menus.indexOf('help') >= 0
      title = "Help"
      sidebars.push @renderSidebar(<HelpMenu />, title)
    if menus.indexOf('filters') >= 0
      title = "Filter documents by..."
      sidebars.push @renderSidebar(<FiltersMenu onFilterClick={@toggleMenu} />, title)
    if menus.indexOf('countries') >= 0
      title = "Countries"
      sidebars.push @renderSidebar(<CountriesMenu />, title)

    sidebars

  render: ->
    className = "app"
    className += " menu-toggled" if @state.menus.length > 0
    <div className={className} id="app">
      {@renderSidebars()}
      <div id="page-content-wrapper" onClick={@dismissMenu}>
        {@renderHeader()}
        <div id="page-content">
          <ReactCSSTransitionGroup transitionName="page" component="div">
            {@renderPage()}
          </ReactCSSTransitionGroup>
        </div>
      </div>
    </div>