LoginMenu = require('components/menus/login_menu')
TranslationHelper = require('mixins/translation_helper')
UrlStore = require('stores/url_store')
UrlActions = require('actions/url_actions')

module.exports = React.createClass
  display: 'LoginPage'

  mixins: [TranslationHelper]
  baseTranslation: ''

  onLogin: ->
    if UrlStore.hasHistory()
      UrlActions.back()
    else
      UrlActions.navigateTo('/')

  render: ->
    <div className="login-page">
      <h1>{@t('menus.login.title')}</h1>
      <LoginMenu onLogin={@onLogin}/>
    </div>
