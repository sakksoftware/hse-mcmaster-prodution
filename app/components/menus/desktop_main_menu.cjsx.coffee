Link = require('components/shared/link')
LayerToggle = require('components/layered_navigation/layer_toggle')
TranslationHelper = require('mixins/translation_helper')
MainMenuHelper = require('mixins/main_menu_helper')

module.exports = React.createClass
  displayName: "DesktopMainMenu"

  mixins: [TranslationHelper, MainMenuHelper]

  propTypes:
    onToggle: React.PropTypes.func.isRequired
    onSelectLanguage: React.PropTypes.func.isRequired

  baseTranslation: 'main_menu'

  render: ->
    <ul className="desktop-main-menu menu-list">
      <li className="menu-item"><Link to="about">{@t('about')}</Link></li>
      <li className="menu-item"><a href="#">{@t('walkthrough')}</a></li>
      <li className="menu-item"><a href="#">{@t('guided_search')}</a></li>
      <li className="menu-item">
        <a href="#">
          <span>{@t('select_language')}</span>
          <span className="dropdown-icon"></span>
        </a>
        <ul className="languages-menu menu-list">
          {@renderLanguages()}
        </ul>
      </li>
      <li className="menu-item menu-item-sign-up">
        <span className="menu-item-icon"></span>
        <LayerToggle menu="signup" onToggle={@props.onToggle}>{@t('create_account')}</LayerToggle>
      </li>
      <li className="menu-item menu-item-login">
        <span className="menu-item-icon"></span>
        <LayerToggle menu="login" onToggle={@props.onToggle}>{@t('login')}</LayerToggle>
      </li>
    </ul>
