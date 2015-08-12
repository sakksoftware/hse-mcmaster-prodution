AboutPage = require('components/about/about_page')
ArticlesPage = require('components/articles/articles_page')
SearchPage = require('components/search/search_page')

Sidebar = require('components/menus/sidebar')
SidebarGroup = require('components/menus/sidebar_group')
MenuToggle = require('components/menus/menu_toggle')
Offcanvas = require('components/menus/offcanvas')

MainMenu = require('components/menus/main_menu')
DesktopMainMenu = require('components/menus/desktop_main_menu')
HelpMenu = require('components/menus/help_menu')
FilterGroupsMenu = require('components/menus/filter_groups_menu')
FiltersMenu = require('components/menus/filters_menu')
CountriesMenu = require('components/menus/countries_menu')
SignupMenu = require('components/menus/signup_menu')
LoginMenu = require('components/menus/login_menu')
LanguagesMenu = require('components/menus/languages_menu')

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: 'App'

  propTypes:
    page: React.PropTypes.string.isRequired

  getInitialState: ->
    currentUser: null

  login: (user) ->
    @dismissMenu()
    @setState(currentUser: user)

  logout: ->
    @setState(currentUser: null)
    @dismissMenu()

  selectLanguage: (language) ->
    console.log('language selected', language)
    @dismissMenu()
    # TODO: implement

  toggleMenu: (menuName, title, menuContext = {}) ->
    @refs.offcanvas.toggleMenu(menuName, title, menuContext)

  dismissMenu: ->
    @refs.offcanvas.dismissMenu(menuName)

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
      when 'search'
        <SearchPage key="search-page"
          onShowMenu={@toggleMenu}
         />
      when 'articles'
        id = @props.args.id
        <ArticlesPage id={id} key={"article-page-#{id}"} />
      when 'about'
        <AboutPage key="about-page" />
      else
        throw new Error("Page not found! Please check the URL")

  renderSidebarGroup: ->
    <SidebarGroup>
      <Sidebar name="help" title="Help">
        <HelpMenu />
      </Sidebar>
      <Sidebar name="signup" title="Signup">
        <SignupMenu />
      </Sidebar>
      <Sidebar name="main" title="Menu">
        <MainMenu currentUser={@state.currentUser}
          onSubMenuClick={@toggleMenu}
          onLogout={@logout}
          onLinkClick={@dismissMenu}
          />
      </Sidebar>
      <Sidebar name="login" title="Login">
        <LoginMenu onLogin={@login} />
      </Sidebar>
      <Sidebar name="languages" title="Languages">
        <LanguagesMenu onSelectLanguage={@selectLanguage} />
      </Sidebar>
      <Sidebar name="filterGroups" title="Filter documents by...">
        <FilterGroupsMenu />
      </Sidebar>
      <Sidebar name="filters" title="Filters">
        <FiltersMenu />
      </Sidebar>
      <Sidebar name="countries" title="Countries">
        <CountriesMenu />
      </Sidebar>
    </SidebarGroup>

  render: ->
    <Offcanvas ref="offcanvas">
      {@renderSidebarGroup()}
      {@renderHeader()}
      <div id="page-content">
        <ReactCSSTransitionGroup transitionName="page" component="div">
          {@renderPage()}
        </ReactCSSTransitionGroup>
      </div>
    </Offcanvas>
