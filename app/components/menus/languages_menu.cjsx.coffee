UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')
languages = require('constants/languages')

module.exports = React.createClass
  displayName: 'LanguagesMenu'

  componentWillMount: ->
    @unsubscribe = UserStore.listen(@userStoreUpdated)

  componentWillUnmount: ->
    @unsubscribe()

  userStoreUpdated: (state) ->
    @setState(langauge: state.language)

  getInitialState: ->
    language: UserStore.state.language

  handleSelectLanguage: (language) ->
    (e) =>
      e.preventDefault()
      UserActions.changeLanguage(language)

  renderCheckMark: (language) ->
    if @state.language == language.name
      <i className="checkmark"></i>

  renderLanguages: ->
    for language, i in languages
      <li className="menu-item" key="language-#{i}" value={language.name}>
        <a className="menu-item-text" href="#" onClick={@handleSelectLanguage(language.name)}>{language.title}</a>
        {@renderCheckMark(language)}
      </li>

  render: ->
    <ul className="languages-menu menu-list">
      {@renderLanguages()}
    </ul>
