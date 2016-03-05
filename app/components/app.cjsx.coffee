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
SavedSearchPage = require('components/saved_search/saved_search_page')
SavedArticlesPage = require('components/saved_articles/saved_articles_page')

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
Hotspot = require('components/tour/hotspot')

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

Dialog = require('components/shared/dialog')
TranslationHelper = require('mixins/translation_helper')

UrlActions = require('actions/url_actions')
UrlStore = require('stores/url_store')
UserActions = require('actions/user_actions')
NotificationActions = require('actions/notification_actions')
UserStore = require('stores/user_store')
NotificationStore = require('stores/notification_store')

Transition = React.addons.CSSTransitionGroup

params = require('lib/url').params()
Util = require('lib/util')

Button = require('components/shared/button')

module.exports = React.createClass
  displayName: 'App'

  mixins: [TranslationHelper]
  baseTranslation: ''

  propTypes:
    page: React.PropTypes.string.isRequired

  getInitialState: ->
    currentUser: UserStore.state.user
    notifications: NotificationStore.state.notifications
    dialogs: NotificationStore.state.dialogs
    dismissBrowserWarning: false

  componentWillMount: ->
    if Cookies.get('token') # only get user if there is a token saved
      UserActions.loadUser()

    @unsubscribeUserStore = UserStore.listen(@updateUser)
    @unsubscribeNotificationStore = NotificationStore.listen(@updateNotifications)

  componentWillUnmount: ->
    @unsubscribeUserStore()
    @unsubscribeNotificationStore()

  componentDidMount: ->
    window.reactAppLoaded = true

  updateUser: (state) ->
    @setState(currentUser: state.user)

  updateNotifications: (state) ->
    @setState(notifications: state.notifications, dialogs: state.dialogs)

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
      <h1><Link to="/">Health Systems Evidence</Link></h1>
      <LayerToggle menu="main" onToggle={@toggleMenu}>
        <Hotspot tourKey="language" />
        <Hotspot tourKey="profile" />
        <Hotspot tourKey="complementary_content" />
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
      </LayerToggle>
      <MainMenu currentUser={@state.currentUser}
        onSubMenuClick={@toggleMenu}
        onLogout={@logout}
        onLinkClick={@dismissMenu}
        onSelectLanguage={@selectLanguage}
        page={@props.page}
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
        <Top5Page key="top-5" />
      when 'login'
        <LoginPage key="login" />
      when 'signup'
        <SignupPage key="signup" />
      when 'newsletter'
        id = @props.args.id
        <NewsletterPage id={id} key="newsletter-#{id}" />
      when 'unsubscribe'
        <UnsubscribePage key="unsubscribe" />
      when 'cookies_disabled'
        <CookiesDisabledPage key="cookies-disabled"/>
      when 'saved_search'
        <SavedSearchPage key="saved-search-page" />
      when 'saved_articles'
        <SavedArticlesPage key="saved-articles-page" />
      ##
      # Errors
      ##
      when 'forgot_password'
        <ForgotPasswordPage key="forgot-password" />
      when 'page_not_found'
        <PageNotFound key="page-not-found" />
      when 'reset_password'
        <ResetPasswordPage lfe={params.lfe} key="reset-password"/>
      when 'application_error'
        <ApplicationErrorPage key="application-error" />
      when 'server_error'
        <ServerErrorPage key="server-error" />
      when 'quota_exceeded_error'
        <QuotaExceededErrorPage key="quota-exceeded-error" />
      when 'timeout_error'
        <TimeoutErrorPage key="timeout-error" />
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

  renderDialog: ->
    for dialog, i in @state.dialogs
      <Dialog key={"dialog-#{i}"} {...dialog} />

  renderDialogBackDrop: ->
    if @state.dialogs.length > 0
      <div key="dialog-backdrop" className="modal-backdrop fade in" />

  renderNotification: ->
    <Transition transitionName="notification-fadeout" component="div">
      {
        if @state.notifications.length > 0
          notification = _.last(@state.notifications)
          type = notification.type || 'success'
          type = 'danger' if type == 'error'

          <div className="alert alert-#{type} alert-dismissible" role="alert">
            <span>{notification.message}</span>
            <Button onClick={=> NotificationActions.dismissNotifications()} className="btn-close">&times;</Button>
          </div>
      }
    </Transition>

  renderBrowserWarning: ->
    browser = require('lib/browser')

    url = ''
    if browser.name == 'ie'
      url = 'http://windows.microsoft.com/en-CA/internet-explorer/download-ie'
    if browser.name == 'chrome'
      url = 'https://support.google.com/chrome/answer/95414?hl=en'
    if browser.name == 'firefox'
      url = 'https://support.mozilla.org/en-US/kb/update-firefox-latest-version'
    if browser.name == 'safari'
      url = 'https://support.apple.com/en-ca/HT204416'

    if !@state.dismissBrowserWarning &&
        params.browser_warning ||
        (browser.name == 'ie' && parseInt(browser.version, 10) < 10) ||
        (browser.name == 'firefox' && parseInt(browser.version, 10) < 40) ||
        (browser.name == 'chrome' && parseInt(browser.version, 10) < 30) ||
        (browser.name == 'safari' && parseInt(browser.version, 10) < 9)
      <div className="browser-warning">
        <p>{@t('errors.old_browser.message')}</p>
        <a href={url}>{@t('errors.old_browser.upgrade')}</a>
        <Button onClick={=> @setState(dismissBrowserWarning: true)} className="btn-close">&times;</Button>
      </div>

  render: ->
    <LayeredNavigation ref="layeredNavigation" className="app #{@props.page}" id="app">
      {@renderLayerGroup()}
      {@renderHeader()}
      {@renderBrowserWarning()}
      {@renderNotification()}
      <div id="page-content">
        <Transition transitionName="page" component="div">
          {@renderPage()}
        </Transition>
      </div>
      <footer>
        <div className="logo-wrapper">
          <img src="/images/mcmaster_logo.svg" className="logo" />
          <img src="/images/mcmaster_forum_logo.svg" className="forum-logo" />
        </div>
        <a href="mailto:hse@mcmaster.ca" target="_blank" className="contact-us">{@t('contact_us')}</a>|
        <Link className="terms" to="/terms">{@t('terms_of_use')}</Link>
      </footer>
      {@renderDialog()}
      {@renderDialogBackDrop()}
    </LayeredNavigation>
