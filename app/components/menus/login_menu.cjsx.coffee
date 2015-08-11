Button = ReactBootstrap.Button
Form = require('components/shared/form')
UserActions = require('actions/user_actions')

module.exports = React.createClass
  displayName: "LoginMenu"
  propTypes:
    dismissMenu: React.PropTypes.func.isRequired

  render: ->
    <Form className="login-menu" onSubmit={UserActions.loginUser} afterSave={@props.dismissMenu}>
      <input label="Email" name="email" type="email" />
      <input label="Password" name="password" type="password" />
      <button className="btn-primary">Login</button>
      <a href="/forgot_password">Forgot your password?</a>
    </Form>
