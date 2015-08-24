Link = require('components/shared/link')

module.exports = React.createClass
  displayName: 'AccountMenu'

  propTypes:
    context: React.PropTypes.object

  componentWillMount: ->
    @onLinkClick = =>
      # dismiss menu on mobile
      # call twice since we are in a second leve menu
      if @props.context?.onLinkClick
        @props.context.onLinkClick()
        _.defer => @props.context.onLinkClick()

  render: ->
    <ul className="account-menu main-menu menu-list">
      <li className="menu-item menu-item-profile">
        <span className="menu-item-icon"></span>
        <Link onClick={@onLinkClick} to="profile">Profile</Link>
      </li>
      <li className="menu-item menu-item-saved-documents">
        <span className="menu-item-icon"></span>
        <Link onClick={@onLinkClick} to="saved_documents">Saved documents</Link>
      </li>
      <li className="menu-item menu-item-saved-searches">
        <span className="menu-item-icon"></span>
        <Link onClick={@onLinkClick} to="save_searches">Saved searches</Link>
      </li>
      <li className="menu-item menu-item-complementary-content">
        <span className="menu-item-icon"></span>
        <Link onClick={@onLinkClick} to="complementary_content">Complementary Content</Link>
      </li>
    </ul>
