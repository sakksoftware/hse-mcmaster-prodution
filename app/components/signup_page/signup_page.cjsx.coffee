SignupMenu = require('components/menus/signup_menu')
TranslationHelper = require('mixins/translation_helper')
UrlActions = require('actions/url_actions')

module.exports = React.createClass
  displayName: 'SignupPage'

  mixins: [TranslationHelper]
  baseTranslation: ''

  onSignup: ->
    UrlActions.navigateTo('/')

  render: ->
    <div className="signup-page">
      <h1>{@t('menus.signup.title')}</h1>
      <SignupMenu onSignup={@onSignup} />
    </div>
