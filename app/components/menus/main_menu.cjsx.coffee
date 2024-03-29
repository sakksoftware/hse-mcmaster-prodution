Link = require('components/shared/link')
LayerToggle = require('components/layered_navigation/layer_toggle')
TranslationHelper = require('mixins/translation_helper')
AccountMenu = require('components/menus/account_menu')
LanguagesMenu = require('components/menus/languages_menu')
Hotspot = require('components/tour/hotspot')

UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')
TourActions = require('actions/tour_actions')

Toggle = ReactToggle

module.exports = React.createClass
  displayName: 'MainMenu'

  mixins: [TranslationHelper]
  baseTranslation: 'main_menu'

  propTypes:
    currentUser: React.PropTypes.object
    onSubMenuClick: React.PropTypes.func.isRequired
    onLinkClick: React.PropTypes.func.isRequired
    onLogout: React.PropTypes.func.isRequired

  fullName: ->
    user = @props.currentUser
    if user.first_name and user.last_name
      user.first_name + " " + user.last_name

  componentWillMount: ->
    TourActions.addSteps
      key: 'language'
      order: 1

    @addUserSteps(@props)

  componentWillUnmount: ->
    TourActions.removeSteps ['language', 'profile', 'complementary_content']

  componentWillReceiveProps: (nextProps) ->
    @addUserSteps(nextProps)

  handleLogout: (e) ->
    e.preventDefault()
    @props.onLogout()

  addUserSteps: (props) ->
    return unless props.currentUser

    TourActions.addSteps [
      {
        key: 'profile'
        order: 5
        beforeStep: -> $('.menu-item-account').addClass('hover')
        afterStep: -> $('.menu-item-account').removeClass('hover')
      }
      {
        key: 'complementary_content'
        order: 12
        beforeStep: -> $('.menu-item-account').addClass('hover')
        afterStep: -> $('.menu-item-account').removeClass('hover')
      }
    ]

  toggleGuidedSearch: ->
    UserActions.toggleGuidedSearch()

  renderUserLinks: ->
    if @props.currentUser
      [
        <li key="menu-item-account" className="menu-item menu-item-account">
          <Hotspot tourKey="profile" />
          <Hotspot tourKey="complementary_content" />
          <span className="menu-item-icon"></span>
          <LayerToggle className="menu-item-text" menu="account" onToggle={@props.onSubMenuClick} context={onLinkClick: @props.onLinkClick}>
            {@fullName() || @props.currentUser.email}
          </LayerToggle>

          <a className="desktop-menu-link menu-item-text" href="#" onClick={(e) -> e.preventDefault()}>{@fullName() || @props.currentUser.email}</a>
          <AccountMenu />
        </li>
        <li key="menu-item-logout" className="menu-item menu-item-logout">
          <span className="menu-item-icon"></span>
          <a className="menu-item-text" href="#" onClick={@handleLogout}>{@t('logout')}</a>
        </li>
      ]
    else
      [
        <li key="menu-item-signup" className="menu-item menu-item-sign-up">
          <span className="menu-item-icon"></span>
          <LayerToggle className="menu-item-text" menu="signup" onToggle={@props.onSubMenuClick}>{@t('create_account')}</LayerToggle>
        </li>
        <li key="menu-item-login" className="menu-item menu-item-login">
          <span className="menu-item-icon"></span>
          <LayerToggle className="menu-item-text" menu="login" onToggle={@props.onSubMenuClick}>{@t('login')}</LayerToggle>
        </li>
      ]

  render: ->
    # <li className="menu-item menu-item-walkthrough">
    #   <a href="#">{@t('walkthrough')}</a>
    # </li>
    <ul className="main-menu menu-list">
      <li className="menu-item menu-item-home">
        <span className="menu-item-icon"></span>
        <Link className="menu-item-text" onClick={@props.onLinkClick} to="/">{@t('home')}</Link>
      </li>
      <li className="menu-item menu-item-about">
        <span className="menu-item-icon"></span>
        <Link className="menu-item-text" onClick={@props.onLinkClick} to="/about">{@t('about')}</Link>
      </li>
      <li className="menu-item menu-item-language">
        <Hotspot tourKey="language" />
        <span className="menu-item-icon"></span>
        <LayerToggle className="menu-item-text" menu="languages" onToggle={@props.onSubMenuClick}>{@t('select_language')}</LayerToggle>

        <a className="desktop-menu-link menu-item-text" href="#" onClick={(e) -> e.preventDefault()}>{@t('select_language')}</a>
        <LanguagesMenu />
      </li>
      <li className="menu-item menu-item-guided-search">
        <span className="menu-item-icon"></span>
        <label className="menu-item-text">
          <span>{@t('guided_search')}</span>
          <Toggle
            defaultChecked={UserStore.state.guidedSearch}
            onChange={this.toggleGuidedSearch} />
        </label>
      </li>
      {@renderUserLinks()}
    </ul>
