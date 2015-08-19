Link = require('components/shared/link')
LayerToggle = require('components/layered_navigation/layer_toggle')
languages = require('constants/languages')

module.exports = React.createClass
  displayName: "DesktopMainMenu"
  propTypes:
    onToggle: React.PropTypes.func.isRequired

  renderLanguages: ->
    for language, i in languages
      <li key="language-#{i}" value={language.name}>
        <a href="#">{language.title}</a>
      </li>

  render: ->
    <ul className="desktop-main-menu menu-list">
      <li className="menu-item"><Link to="about">About HSE</Link></li>
      <li className="menu-item"><a href="#">Walk through</a></li>
      <li className="menu-item"><a href="#">Guided Search</a></li>
      <li className="menu-item">
        <a href="#">
          <span>Select language</span>
          <span className="dropdown-icon"></span>
        </a>
        <ul>
          {@renderLanguages()}
        </ul>
      </li>
      <li className="menu-item menu-item-sign-up">
        <span className="menu-item-icon"></span>
        <LayerToggle menu="signup" onToggle={@props.onToggle}>Create Account</LayerToggle>
      </li>
      <li className="menu-item menu-item-login">
        <span className="menu-item-icon"></span>
        <LayerToggle menu="login" onToggle={@props.onToggle}>Login</LayerToggle>
      </li>
    </ul>
