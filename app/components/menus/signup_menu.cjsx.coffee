Button = ReactBootstrap.Button
Form = require('components/shared/form')
Input = require('components/shared/input')
UserActions = require('actions/user_actions')

module.exports = React.createClass
  displayName: "SignupMenu"

  render: ->
    <Form className="signup-menu" onSubmit={UserActions.createUser}>
      <input label="Email" name="email"/>
      <input label="Password" name="password" />
      <input label="Confirm password" name="confirm_password" />
      <input label='I accept the' type='checkbox' name="accept_terms" />
      <a href="/terms-of-use" target="_blank">Terms of Use</a>
      <button className='btn-primary'>Create account</button>
    </Form>
