Link = require('components/shared/link')
MenuToggle = require('components/menus/menu_toggle')

module.exports = React.createClass
  displayName: 'MainMenu'
  propTypes:
    onSubMenuClick: React.PropTypes.func.isRequired

  render: ->
    <ul className="sidebar-nav menu-list">
      <li className="menu-item menu-item-home">
        <span className="menu-item-icon"></span>
        <Link to="/">Home</Link>
      </li>
      <li className="menu-item menu-item-language">
        <span className="menu-item-icon"></span>
        <Link to="language">Select Language</Link>
      </li>
      <li className="menu-item menu-item-about">
        <span className="menu-item-icon"></span>
        <Link to="/about">About HSE</Link>
      </li>
      <li className="menu-item menu-item-sign-up">
        <span className="menu-item-icon"></span>
        <MenuToggle menu="signup" onToggle={@props.onSubMenuClick}>Sign Up</MenuToggle>
      </li>
      <li className="menu-item menu-item-login">
        <span className="menu-item-icon"></span>
        <Link to="/login">Login</Link>
      </li>
    </ul>
