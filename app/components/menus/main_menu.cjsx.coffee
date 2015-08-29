Link = require('components/shared/link')
LayerToggle = require('components/layered_navigation/layer_toggle')
TranslationHelper = require('mixins/translation_helper')
AccountMenu = require('components/menus/account_menu')
LanguagesMenu = require('components/menus/languages_menu')
UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')

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

  handleLogout: (e) ->
    e.preventDefault()
    @props.onLogout()

  toggleGuidedSearch: ->
    UserActions.toggleGuidedSearch()


  renderUserLinks: ->
    if @props.currentUser
      [
        <li key="menu-item-account" className="menu-item menu-item-account">
          <span className="menu-item-icon"></span>
          <LayerToggle menu="account" onToggle={@props.onSubMenuClick} context={onLinkClick: @props.onLinkClick}>
            {@fullName() || @props.currentUser.email}
          </LayerToggle>

          <a className="desktop-menu-link" href="#">{@fullName() || @props.currentUser.email}</a>
          <AccountMenu />
        </li>
        <li key="menu-item-logout" className="menu-item menu-item-logout">
          <span className="menu-item-icon"></span>
          <a href="#" onClick={@handleLogout}>{@t('logout')}</a>
        </li>
      ]
    else
      [
        <li key="menu-item-signup" className="menu-item menu-item-sign-up">
          <span className="menu-item-icon"></span>
          <LayerToggle menu="signup" onToggle={@props.onSubMenuClick}>{@t('create_account')}</LayerToggle>
        </li>
        <li key="menu-item-login" className="menu-item menu-item-login">
          <span className="menu-item-icon"></span>
          <LayerToggle menu="login" onToggle={@props.onSubMenuClick}>{@t('login')}</LayerToggle>
        </li>
      ]

  render: ->
    # <li className="menu-item menu-item-walkthrough">
    #   <a href="#">{@t('walkthrough')}</a>
    # </li>
    <ul className="main-menu menu-list">
      <li className="menu-item menu-item-home">
        <span className="menu-item-icon"></span>
        <Link onClick={@props.onLinkClick} to="/">{@t('home')}</Link>
      </li>
      <li className="menu-item menu-item-about">
        <span className="menu-item-icon"></span>
        <Link onClick={@props.onLinkClick} to="/about">{@t('about')}</Link>
      </li>
      <li className="menu-item menu-item-language">
        <span className="menu-item-icon"></span>
        <LayerToggle menu="languages" onToggle={@props.onSubMenuClick}>{@t('select_language')}</LayerToggle>

        <a className="desktop-menu-link" href="#">{@t('select_language')}</a>
        <LanguagesMenu />
      </li>
      <li className="menu-item menu-item-guided-search">
        <span className="menu-item-icon"></span>
        <label>
          <Toggle
            defaultChecked={UserStore.state.guidedSearch}
            onChange={this.toggleGuidedSearch} />
          <span>{@t('guided_search')}</span>
        </label>
      </li>
      {@renderUserLinks()}
    </ul>
