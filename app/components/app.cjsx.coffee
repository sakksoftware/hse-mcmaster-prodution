ArticlesPage = require('components/articles/articles_page')
SearchPage = require('components/search/search_page')
StaticPage = require('components/static/static_page')
ProfilePage = require('components/profile/profile_page')

Layer = require('components/layered_navigation/layer')
LayerGroup = require('components/layered_navigation/layer_group')
LayerToggle = require('components/layered_navigation/layer_toggle')
LayeredNavigation = require('components/layered_navigation/layered_navigation')

Link = require('components/shared/link')

MainMenu = require('components/menus/main_menu')
HelpMenu = require('components/menus/help_menu')
FilterGroupsMenu = require('components/menus/filter_groups_menu')
FiltersMenu = require('components/menus/filters_menu')
CountriesMenu = require('components/menus/countries_menu')
DateRangeMenu = require('components/menus/date_range_menu')
SignupMenu = require('components/menus/signup_menu')
LoginMenu = require('components/menus/login_menu')
LanguagesMenu = require('components/menus/languages_menu')
AccountMenu = require('components/menus/account_menu')

TranslationHelper = require('mixins/translation_helper')

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: 'App'

  mixins: [TranslationHelper]
  baseTranslation: ''

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
      <MainMenu currentUser={@state.currentUser}
        onSubMenuClick={@toggleMenu}
        onLogout={@logout}
        onLinkClick={@dismissMenu}
        onSelectLanguage={@selectLanguage}
      />
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
        <StaticPage name="about" key="about-page" />
      when 'terms'
        <StaticPage name="terms" key="terms-page" />
      when 'profile'
        <ProfilePage key="profile-page" />
      else
        # TODO: display a 404 here!
        throw new Error("Page not found! Please check the URL")

  renderLayerGroup: ->
    <LayerGroup>
      <Layer name="help" title={@t('menus.help.title')}>
        <HelpMenu />
      </Layer>
      <Layer name="signup" title={@t('menus.signup.title')}>
        <SignupMenu />
      </Layer>
      <Layer name="main" title={@t('menus.main.title')}>
        <MainMenu currentUser={@state.currentUser}
          onSubMenuClick={@toggleMenu}
          onLogout={@logout}
          onLinkClick={@dismissMenu}
          />
      </Layer>
      <Layer name="login" title={@t('menus.login.title')}>
        <LoginMenu onLogin={@login} />
      </Layer>
      <Layer name="languages" title={@t('menus.languages.title')}>
        <LanguagesMenu />
      </Layer>
      <Layer name="account" title={@t('menus.account.title')}>
        <AccountMenu />
      </Layer>

      <Layer name="filterGroups" title={@t('menus.filter_groups.title')}>
        <FilterGroupsMenu />
      </Layer>
      <Layer name="filters" title={@t('menus.filters.title')}>
        <FiltersMenu />
      </Layer>
      <Layer name="countries" title={@t('menus.countries.title')}>
        <CountriesMenu />
      </Layer>
      <Layer name="dateRange" title={@t('menus.date_range.date_range')}>
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
        <Link className="terms" to="terms">{@t('terms_of_use')}</Link>
      </footer>
    </LayeredNavigation>
