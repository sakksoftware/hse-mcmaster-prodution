Button = ReactBootstrap.Button
Form = require('components/shared/form')
UserActions = require('actions/user_actions')

module.exports = React.createClass
  displayName: "LoginMenu"
  render: ->
    <Form className="login-menu" onSubmit={UserActions.loginUser}>
      <input label="Email" name="email" />
      <input label="Password" name="password" />
      <button className="btn-primary">Login</button>
      <a href="/forgot_password">Forgot your password?</a>
    </Form>
