Button = ReactBootstrap.Button
Form = require('components/shared/form')
UserActions = require('actions/user_actions')

module.exports = React.createClass
  displayName: "LoginMenu"
  propTypes:
    onLogin: React.PropTypes.func.isRequired

  afterSave: (user) ->
    @props.onLogin(user)

  render: ->
    <Form className="login-menu" onSubmit={UserActions.loginUser} afterSave={@afterSave}>
      <input label="Email" name="email" type="email" />
      <input label="Password" name="password" type="password" />
      <button className="btn-primary">Login</button>
      <a href="/forgot_password">Forgot your password?</a>
    </Form>
