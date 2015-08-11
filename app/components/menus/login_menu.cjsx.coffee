Button = ReactBootstrap.Button
Form = require('components/shared/form')

module.exports = React.createClass
  displayName: "LoginMenu"
  render: ->
    <Form className="login-menu">
      <input label="Email" />
      <input label="Password" />
      <Button bsStyle='primary' block>Login</Button>
      <a href="/forgot_password">Forgot your password?</a>
    </Form>
