Link = require('components/shared/link')

module.exports = React.createClass
  displayName: 'Sidebar'
  propTypes:
    onClose: React.PropTypes.onClose

  render: ->
    <nav id="sidebar-wrapper" role="navigation">
      <div className="sidebar">
        <div className="sidebar-header">
          <span className="sidebar-header-title">Menu</span>
          <a className="sidebar-header-close" href="#">x</a>
        </div>
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
            <Link to="/signup">Sign Up</Link>
          </li>
          <li className="menu-item menu-item-login">
            <span className="menu-item-icon"></span>
            <Link to="/login">Login</Link>
          </li>
        </ul>
      </div>
    </nav>