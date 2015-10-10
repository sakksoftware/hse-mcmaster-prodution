Button = ReactBootstrap.Button
Form = require('components/shared/form')
UserActions = require('actions/user_actions')
TranslationHelper = require('mixins/translation_helper')
Recaptcha = require('lib/recaptcha')
config = require('config')

module.exports = React.createClass
  displayName: "SignupMenu"
  mixins: [TranslationHelper]
  baseTranslation: 'menus.signup'

  propTypes:
    onSignup: React.PropTypes.func
    user: React.PropTypes.object

  getDefaultProps: ->
    onSignup: (->)

  getInitialState: ->
    errors: null

  handleSubmit: (user, success, error) ->
    # TODO: identical segments to Reset Password Page, refactor into a service? /validations folder?
    if user.confirm_password != user.password
      user.errors ||= {}
      user.errors.confirm_password = @t('/errors.passwords_must_match')
    if _.isEmpty(user.confirm_password)
      user.errors ||= {}
      user.errors.confirm_password = @t('/errors.cant_be_blank')
    if _.isEmpty(user.password)
      user.errors ||= {}
      user.errors.password = @t('/errors.cant_be_blank')

    if _.isEmpty(user.captcha)
      user.errors ||= {}
      user.errors.captcha = @t('/errors.cant_be_blank')

    if user.errors
      error(responseText: JSON.stringify(user))
    else
      UserActions.createUser(user).then(success).catch(error)

  handleError: (errors) ->
    @setState(errors: errors)

  renderRecaptcha: ->
    error =
      if @state.errors?.captcha
        <span className="help-block">{@state.errors.captcha}</span>

    className = "form-group recaptcha-group"
    className += " has-feedback has-error" if error

    <div className={className}>
      <Recaptcha sitekey={config.recaptchaKey} />
      {error}
    </div>

  render: ->
    <Form className="signup-menu"
      onSubmit={@handleSubmit}
      afterSave={@props.onSignup}
      onError={@handleError}
      model={@props.user}>
      <input label={@t('email')} name="email" type="email" />
      <input label={@t('password')} name="password" type="password" />
      <input label={@t('confirm_password')} name="confirm_password" type="password" />
      <input label={@t('i_accept')} type='checkbox' name="accept_terms" />
      <a href="/terms" className="btn-terms" target="_blank">{@t('terms')}</a>
      {@renderRecaptcha()}

      <button className='btn-primary'>{@t('signup_button')}</button>
    </Form>
