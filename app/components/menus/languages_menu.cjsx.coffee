UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')
languages = require('constants/languages')

module.exports = React.createClass
  displayName: 'LanguagesMenu'

  handleSelectLanguage: (language) ->
    (e) =>
      e.preventDefault()
      UserActions.changeLanguage(language)

  getCurrentLanguage: ->
    UserStore.state.language

  renderCheckMark: (language) ->
    if @getCurrentLanguage() == language.name
      <i className="checkmark"></i>

  renderLanguages: ->
    for language, i in languages
      <li className="menu-item" key="language-#{i}" value={language.name}>
        <a href="#" onClick={@handleSelectLanguage(language.name)}>{language.title}</a>
        {@renderCheckMark(language)}
      </li>

  render: ->
    <ul className="languages-menu menu-list">
      {@renderLanguages()}
    </ul>
