MainMenuHelper = require('mixins/main_menu_helper')

module.exports = React.createClass
  displayName: 'LanguagesMenu'
  mixins: [MainMenuHelper]
  propTypes: ->
    onSelectLanguage: React.PropTypes.func.isRequired

  render: ->
    <ul className="languages-menu menu-list">
      {@renderLanguages()}
    </ul>
