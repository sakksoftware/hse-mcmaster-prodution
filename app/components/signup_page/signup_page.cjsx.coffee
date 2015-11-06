SignupMenu = require('components/menus/signup_menu')
TranslationHelper = require('mixins/translation_helper')
UrlActions = require('actions/url_actions')
Link = require('components/shared/link')

module.exports = React.createClass
  displayName: 'SignupPage'

  mixins: [TranslationHelper]
  baseTranslation: 'menus.signup'

  componentDidMount: ->
    document.title = "#{@t('title')} | #{@t('/site_name')}"

  onSignup: ->
    UrlActions.navigateTo('/')

  render: ->
    <div className="signup-page">
      <h1>{@t('title')}</h1>
      <SignupMenu onSignup={@onSignup} />
      <hr />
      <p>{@t('already_have_account')} <Link to="/login">{@t('login')}</Link></p>
    </div>
