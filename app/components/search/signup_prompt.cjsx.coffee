SignupMenu = require('components/menus/signup_menu')
Recaptcha = require('lib/recaptcha')
config = require('config')
UserActions = require('actions/user_actions')

module.exports = React.createClass
  displayName: 'SignupPrompt'

  steps: ['account_details', 'captcha']

  getInitialState: ->
    step: _.first(@steps)
    formData: {}
    isDismissed: false

  onDismiss: (e) ->
    e.preventDefault()
    @dismiss()

  dismiss: ->
    @setState(isDismissed: true)

  nextStep: ->
    data = $(@refs.account_details_form.getDOMNode()).serializeObject()
    @setState(formData: data, step: 'captcha')

  createAccount: ->
    UserActions.createUser(@state.formData).then =>
      @setState(isDismissed: true)

  verifyCallback: (response) ->
    data = _.clone(@state.formData)
    data.captcha = response
    @setState(formData: data)

  renderStep: ->
    switch @state.step
      when 'account_details'
        <div key="account_details">
          <SignupMenu ref="account_details_form" key="account_details" onSignup={@nextStep} />
          <button onClick={@nextStep}>Next</button>
        </div>
      when 'captcha'
        <div key="captcha">
          <Recaptcha ref="captcha_form" key="captcha" sitekey={config.recaptchaKey} verifyCallback={@verifyCallback} />
          <button onClick={@createAccount}>Create Account</button>
        </div>

  render: ->
    return false if @state.isDismissed

    <div className="signup-prompt">
      <div className="signup-prompt-title">
        Sign up to view more than 20 results, to save documents and searches,
        and to subscribe to email alerts
        <a href="#" className="signup-prompt-dismiss" onClick={@onDismiss}>x</a>
      </div>
      {@renderStep()}
    </div>
