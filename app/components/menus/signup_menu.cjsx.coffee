Button = ReactBootstrap.Button
Form = require('components/shared/form')
UserActions = require('actions/user_actions')

module.exports = React.createClass
  displayName: "SignupMenu"

  afterSaveContent: ->
    <div>
      <h3 className='confirmation-msg'>A conformation email has been sent to you. Pleaes confirm your registration to activate your account!</h3>
      <small>Didn&#39;t receive an emai? <a href="#">Send Again</a></small>
    </div>

  render: ->
    <Form className="signup-menu"
      afterSaveContent={@afterSaveContent}
      replaceContent=true onSubmit={UserActions.createUser}>
      <input label="Email" name="email" type="email" />
      <input label="Password" name="password" type="password" />
      <input label="Confirm password" name="confirm_password" type="password" />
      <input label='I accept the' type='checkbox' name="accept_terms" />
      <a href="/terms-of-use" target="_blank">Terms of Use</a>
      <button className='btn-primary'>Create account</button>
    </Form>
