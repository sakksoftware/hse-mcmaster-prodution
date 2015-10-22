Link = require('components/shared/link')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'AccountMenu'

  mixins: [TranslationHelper]
  baseTranslation: 'menus.account'

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
    # TODO: need to consolidate styles to use the same approach to icons, either use the icon
    # css file with before psedue elements or use real elements like this
    <ul className="account-menu main-menu menu-list">
      <li className="menu-item menu-item-profile">
        <span className="menu-item-icon"></span>
        <Link className="menu-item-text" onClick={@onLinkClick} to="/profile">{@t('profile')}</Link>
      </li>
      <li className="menu-item menu-item-saved-articles">
        <span className="menu-item-icon"></span>
        <Link className="menu-item-text" onClick={@onLinkClick} to="/user/articles">{@t('saved_documents')}</Link>
      </li>
      <li className="menu-item menu-item-saved-searches">
        <span className="menu-item-icon"></span>
        <Link className="menu-item-text" onClick={@onLinkClick} to="/user/searches">{@t('saved_searches')}</Link>
      </li>
      <li className="menu-item menu-item-complementary-content">
        <span className="menu-item-icon"></span>
        <Link className="menu-item-text" onClick={@onLinkClick} to="/complementary_content">{@t('complementary_content')}</Link>
      </li>
    </ul>
