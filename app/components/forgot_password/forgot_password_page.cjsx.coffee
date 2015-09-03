Form = require('components/shared/form')
UserActions = require('actions/user_actions')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'ForgotPasswordPage'
  mixins: [TranslationHelper]
  baseTranslation: 'forgot_password_page'

  handleSubmit: (formData, success, error) ->
    UserActions.forgotPassword(formData).then(success, error)

  afterSaveContent: ->
    <div className="forgot-password-success">
      <h1>{@t('title')}</h1>
      <p>{@t('on_success')}</p>
    </div>

  render: ->
    <Form className="forgot-password-page" onSubmit={@handleSubmit} afterSaveContent={@afterSaveContent} replaceContent={true}>
      <h1>{@t('title')}</h1>
      <p>{@t('instructions')}</p>
      <input label={@t('email')} name="email" type="email" />
      <button>{@t('submit')}</button>
    </Form>
