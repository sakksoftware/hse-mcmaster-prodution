languages = require('constants/languages')

module.exports =
  handleSelectLanguage: (language) ->
    (e) =>
      e.preventDefault()
      @props.onSelectLanguage(language)

  getCurrentLanguage: ->
    Cookies.get('lng') || 'en'

  renderCheckMark: (language) ->
    if @getCurrentLanguage() == language.name
      <i className="checkmark"></i>

  renderLanguages: ->
    for language, i in languages
      <li className="menu-item" key="language-#{i}" value={language.name}>
        <a href="#" onClick={@handleSelectLanguage(language.name)}>{language.title}</a>
        {@renderCheckMark(language)}
      </li>
