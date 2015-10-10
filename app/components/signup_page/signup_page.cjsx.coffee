SignupMenu = require('components/menus/signup_menu')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SignupPage'

  mixins: [TranslationHelper]
  baseTranslation: ''

  render: ->
    <div className="signup-page">
      <h1>{@t('menus.signup.title')}</h1>
      <SignupMenu />
    </div>
