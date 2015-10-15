HomePage = require('components/home/home_page')
ArticlesPage = require('components/articles/articles_page')
SearchPage = require('components/search/search_page')
StaticPage = require('components/static/static_page')
ProfilePage = require('components/profile/profile_page')
ComplementaryContentPage = require('components/complementary_content/complementary_content_page')
Top5Page = require('components/top_5/top_5_page')
ForgotPasswordPage = require('components/forgot_password/forgot_password_page')
ResetPasswordPage = require('components/reset_password/reset_password_page')
LoginPage = require('components/login_page/login_page')
SignupPage = require('components/signup_page/signup_page')
NewsletterPage = require('components/newsletter_page/newsletter_page')
UnsubscribePage = require('components/unsubscribe_page/unsubscribe_page')

PageNotFound = require('components/error_pages/page_not_found')
ServerErrorPage = require('components/error_pages/server_error_page')
ApplicationErrorPage = require('components/error_pages/application_error_page')
TimeoutErrorPage = require('components/error_pages/timeout_error_page')
QuotaExceededErrorPage = require('components/error_pages/quota_exceeded_error_page')
CookiesDisabledPage = require('components/error_pages/cookies_disabled')

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

UrlActions = require('actions/url_actions')
UrlStore = require('stores/url_store')
UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

params = require('lib/url').params()
Util = require('lib/util')

module.exports = React.createClass
  displayName: 'App'

  mixins: [TranslationHelper]
  baseTranslation: ''

  propTypes:
    page: React.PropTypes.string.isRequired

  getInitialState: ->
    currentUser: null

  componentWillMount: ->
    if Cookies.get('token') # only get user if there is a token saved
      UserActions.loadUser()

    @unsubscribe = UserStore.listen(@updateUser)

  componentWillUnmount: ->
    @unsubscribe()

  updateUser: (state) ->
    @setState(currentUser: state.user)

  login: (user) ->
    @dismissMenu()

  logout: ->
    UserActions.logoutUser()
    if window.location.pathname == '/profile'
      UrlActions.navigateTo('/')
    @dismissMenu()

  signup: (user) ->
    @dismissMenu()

  toggleMenu: (menuName, title, menuContext = {}) ->
    @refs.layeredNavigation.toggleMenu(menuName, title, menuContext)

  dismissMenu: ->
    @refs.layeredNavigation.dismissMenu()

  setOverlayContent: (content) ->
    @refs.layeredNavigation.setOverlayContent(content)

  renderHeader: ->
    <nav className="top-nav">
      <h1><Link to="/">Health Systems Evidence</Link><span className="beta">{@t('/beta')}</span></h1>
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
    if !Util.areCookiesEnabled() && @props.page != 'cookies_disabled'
      UrlActions.navigateTo('/cookies_disabled')

    # TODO: replace with react router
    switch @props.page
      when 'home'
        <HomePage
          onShowMenu={@toggleMenu}
          dismissMenu={@dismissMenu}
        />
      when 'search'
        <SearchPage key="search-page"
          onShowMenu={@toggleMenu}
          dismissMenu={@dismissMenu}
          setOverlayContent ={@setOverlayContent}
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
      when 'complementary_content'
        <ComplementaryContentPage key="complementary-content-page" />
      when 'top_5'
        <Top5Page />
      when 'login'
        <LoginPage />
      when 'signup'
        <SignupPage />
      when 'newsletter'
        id = @props.args.id
        <NewsletterPage id={id}/>
      when 'unsubscribe'
        <UnsubscribePage />
      when 'cookies_disabled'
        <CookiesDisabledPage />
      ##
      # Errors
      ##
      when 'forgot_password'
        <ForgotPasswordPage />
      when 'page_not_found'
        <PageNotFound />
      when 'reset_password'
        <ResetPasswordPage lfe={params.lfe} />
      when 'application_error'
        <ApplicationErrorPage />
      when 'server_error'
        <ServerErrorPage />
      when 'quota_exceeded_error'
        <QuotaExceededErrorPage />
      when 'timeout_error'
        <TimeoutErrorPage />
      else
        # should never reach here, programming error.
        throw new Error("Page not found! Please check the URL")

  renderLayerGroup: ->
    <LayerGroup>
      <Layer name="help" title={@t('menus.help.title')}>
        <HelpMenu />
      </Layer>
      <Layer name="signup" title={@t('menus.signup.title')}>
        <SignupMenu onSignup={@signup}/>
      </Layer>
      <Layer name="main" title={@t('menus.main.title')}>
        <MainMenu currentUser={@state.currentUser}
          onSubMenuClick={@toggleMenu}
          onLogout={@logout}
          onLinkClick={@dismissMenu}
          />
      </Layer>
      <Layer name="login" title={@t('menus.login.title')}>
        <LoginMenu onLogin={@login} onForgotPasswordClick={@dismissMenu} />
      </Layer>
      <Layer name="languages" title={@t('menus.languages.title')}>
        <LanguagesMenu />
      </Layer>
      <Layer name="account" title={@t('menus.account.title')}>
        <AccountMenu />
      </Layer>

      <Layer name="filterGroups" title={@t('menus.filter_groups.title')}>
        <FilterGroupsMenu setOverlayContent={@setOverlayContent} />
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
    <LayeredNavigation ref="layeredNavigation" className="app #{@props.page}" id="app">
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
        <Link className="terms" to="/terms">{@t('terms_of_use')}</Link>
      </footer>
    </LayeredNavigation>
