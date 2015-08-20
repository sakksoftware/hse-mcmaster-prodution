# TODO: can probalby combine the main menu and the desktop menu
Link = require('components/shared/link')
LayerToggle = require('components/layered_navigation/layer_toggle')

module.exports = React.createClass
  displayName: 'MainMenu'
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

  renderUserLinks: ->
    if @props.currentUser
      [
        <li key="menu-item-profile" className="menu-item menu-item-profile">
          <span className="menu-item-icon"></span>
          <a href="#">{@fullName() || @props.currentUser.email}</a>
        </li>
        <li key="menu-item-logout" className="menu-item menu-item-logout">
          <span className="menu-item-icon"></span>
          <a href="#" onClick={@handleLogout}>Logout</a>
        </li>
      ]
    else
      [
        <li key="menu-item-signup" className="menu-item menu-item-sign-up">
          <span className="menu-item-icon"></span>
          <LayerToggle menu="signup" onToggle={@props.onSubMenuClick}>Sign Up</LayerToggle>
        </li>
        <li key="menu-item-login" className="menu-item menu-item-login">
          <span className="menu-item-icon"></span>
          <LayerToggle menu="login" onToggle={@props.onSubMenuClick}>Login</LayerToggle>
        </li>
      ]

  render: ->
    <ul className="main-menu menu-list">
      <li className="menu-item menu-item-home">
        <span className="menu-item-icon"></span>
        <Link onClick={@props.onLinkClick} to="/">Home</Link>
      </li>
      <li className="menu-item menu-item-about">
        <span className="menu-item-icon"></span>
        <Link onClick={@props.onLinkClick} to="/about">About HSE</Link>
      </li>
      <li className="menu-item menu-item-language">
        <span className="menu-item-icon"></span>
        <LayerToggle menu="languages" onToggle={@props.onSubMenuClick}>Select Language</LayerToggle>
      </li>
      {@renderUserLinks()}
    </ul>
