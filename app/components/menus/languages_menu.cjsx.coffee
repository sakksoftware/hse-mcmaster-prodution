module.exports = React.createClass
  displayName: 'LanguagesMenu'
  propTypes: ->
    onSelectLanguage: React.PropTypes.func.isRequired

  handleSelectLanguage: (language) ->
    (e) =>
      e.preventDefault()
      @props.onSelectLanguage(language)

  render: ->
    <ul className="languages-menu menu-list">
      <li className="menu-item"><a href="#" onClick={@handleSelectLanguage('en')}>English</a></li>
      <li className="menu-item"><a href="#" onClick={@handleSelectLanguage('cn')}>Chinese</a></li>
      <li className="menu-item"><a href="#" onClick={@handleSelectLanguage('fr')}>French</a></li>
      <li className="menu-item"><a href="#" onClick={@handleSelectLanguage('pt')}>Portuguese</a></li>
      <li className="menu-item"><a href="#" onClick={@handleSelectLanguage('es')}>Spanish</a></li>
    </ul>
