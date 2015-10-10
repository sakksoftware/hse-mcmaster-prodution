LoginMenu = require('components/menus/login_menu')
TranslationHelper = require('mixins/translation_helper')
UrlActions = require('actions/url_actions')

module.exports = React.createClass
  display: 'LoginPage'

  mixins: [TranslationHelper]
  baseTranslation: ''

  onLogin: ->
    UrlActions.navigateTo('/')

  render: ->
    <div className="login-page">
      <h1>{@t('menus.login.title')}</h1>
      <LoginMenu onLogin={@onLogin}/>
    </div>
