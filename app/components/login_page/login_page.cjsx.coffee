LoginMenu = require('components/menus/login_menu')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  display: 'LoginPage'

  mixins: [TranslationHelper]
  baseTranslation: ''

  render: ->
    <div className="login-page">
      <h1>{@t('menus.login.title')}</h1>
      <LoginMenu />
    </div>
