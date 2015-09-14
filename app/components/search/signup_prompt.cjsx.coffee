SignupMenu = require('components/menus/signup_menu')
Recaptcha = require('lib/recaptcha')
config = require('config')
UserActions = require('actions/user_actions')
TranslationHelper = require('mixins/translation_helper')
Button = require('components/shared/button')

module.exports = React.createClass
  displayName: 'SignupPrompt'

  mixins: [TranslationHelper]
  baseTranslation: 'search_page.signup_prompt'

  steps: ['account_details', 'captcha']

  getInitialState: ->
    step: _.first(@steps)
    user: {}
    isDismissed: false

  onDismiss: (e) ->
    e.preventDefault()
    @dismiss()

  dismiss: ->
    @setState(isDismissed: true)

  nextStep: ->
    data = $(@refs.account_details_form.getDOMNode()).serializeObject()
    @setState(user: data, step: 'captcha')

  prevStep: ->
    @setState(step: 'account_details')

  createAccount: ->
    UserActions.createUser(@state.user).then((=> @setState(isDismissed: true))).catch (xhr) =>
      user = xhr.responseJSON

      # TODO: duplicate from Form component... needs to be refactored into an adapter
      # transform data for .NET
      errors = user.errors
      if _.isArray(errors)
        _errors = {}
        for error in errors
          _errors[error.key] = @t('/' + error.value)
        errors = _errors
      user.errors = errors

      if user.errors.captcha && user.errors.length == 1
        @setState(user: user, step: 'captcha')
      else
        @setState(user: user, step: 'account_details')

  verifyCallback: (response) ->
    data = _.clone(@state.user)
    data.captcha = response
    @setState(user: data)

  renderStep: ->
    switch @state.step
      when 'account_details'
        <div key="account_details">
          <SignupMenu user={@state.user} ref="account_details_form" key="account_details" onSignup={@nextStep} />
          <Button className="btn-primary" onClick={@nextStep}>Next</Button>
        </div>
      when 'captcha'
        errors =
          if @state.user.errors?.captcha
            <div className="form-errors">@t('/errors.invalid')</div>

        <div key="captcha">
          <Recaptcha ref="captcha_form" key="captcha" sitekey={config.recaptchaKey} verifyCallback={@verifyCallback} />
          <Button className="btn-prev" onClick={@prevStep}>Prev</Button>
          <Button className="btn-primary btn-next" onClick={@createAccount}>Create Account</Button>
        </div>

  render: ->
    return false if @state.isDismissed

    <div className="signup-prompt">
      <div className="signup-prompt-title">
        {@t('instructions')}
        <a href="#" className="signup-prompt-dismiss" onClick={@onDismiss}>&#x00D7;</a>
      </div>
      <div className="signup-prompt-content">
        {@renderStep()}
      </div>
    </div>
