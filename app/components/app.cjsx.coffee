AboutPage = require('components/about/about_page')
ArticlesPage = require('components/articles/articles_page')
SearchPage = require('components/search/search_page')
TermsPage = require('components/terms/terms_page')

Layer = require('components/layered_navigation/layer')
LayerGroup = require('components/layered_navigation/layer_group')
LayerToggle = require('components/layered_navigation/layer_toggle')
LayeredNavigation = require('components/layered_navigation/layered_navigation')

Link = require('components/shared/link')

MainMenu = require('components/menus/main_menu')
DesktopMainMenu = require('components/menus/desktop_main_menu')
HelpMenu = require('components/menus/help_menu')
FilterGroupsMenu = require('components/menus/filter_groups_menu')
FiltersMenu = require('components/menus/filters_menu')
CountriesMenu = require('components/menus/countries_menu')
DateRangeMenu = require('components/menus/date_range_menu')
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
    @refs.offcanvas.dismissMenu()

  renderHeader: ->
    <nav className="top-nav">
      <h1><Link to="/">Health System Evidence</Link></h1>
      <LayerToggle menu="main" onToggle={@toggleMenu}>
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
      </LayerToggle>
      <DesktopMainMenu />
    </nav>

  renderPage: ->
    # TODO: can be generalized by invoking the right factory based on page name passed in
    # and passing the arguments
    switch @props.page
      when 'search'
        <SearchPage key="search-page"
          onShowMenu={@toggleMenu}
          dismissMenu={@dismissMenu}
         />
      when 'articles'
        id = @props.args.id
        <ArticlesPage id={id} key={"article-page-#{id}"} />
      when 'about'
        <AboutPage key="about-page" />
      when 'terms'
        <TermsPage key="terms-page" />
      else
        # TODO: display a 404 here!
        throw new Error("Page not found! Please check the URL")

  renderLayerGroup: ->
    <LayerGroup>
      <Layer name="help" title="Help">
        <HelpMenu />
      </Layer>
      <Layer name="signup" title="Signup">
        <SignupMenu />
      </Layer>
      <Layer name="main" title="Menu">
        <MainMenu currentUser={@state.currentUser}
          onSubMenuClick={@toggleMenu}
          onLogout={@logout}
          onLinkClick={@dismissMenu}
          />
      </Layer>
      <Layer name="login" title="Login">
        <LoginMenu onLogin={@login} />
      </Layer>
      <Layer name="languages" title="Languages">
        <LanguagesMenu onSelectLanguage={@selectLanguage} />
      </Layer>
      <Layer name="filterGroups" title="Filter documents by...">
        <FilterGroupsMenu />
      </Layer>
      <Layer name="filters" title="Filters">
        <FiltersMenu />
      </Layer>
      <Layer name="countries" title="Countries">
        <CountriesMenu />
      </Layer>
      <Layer name="dateRange" title="Date Range">
        <DateRangeMenu />
      </Layer>
    </LayerGroup>

  render: ->
    <LayeredNavigation ref="offcanvas" className="app" id="app">
      {@renderLayerGroup()}
      {@renderHeader()}
      <div id="page-content">
        <ReactCSSTransitionGroup transitionName="page" component="div">
          {@renderPage()}
        </ReactCSSTransitionGroup>
      </div>
      <footer>
        <div className="logo-wrapper">
          <img src="/images/mcmaster_logo.svg" className="logo" />
          <img src="/images/mcmaster_forum_logo.svg" className="forum-logo" />
        </div>
        <Link className="terms" to="terms">Terms of use</Link>
      </footer>
    </LayeredNavigation>
