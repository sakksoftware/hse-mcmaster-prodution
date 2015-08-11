Input = require('components/shared/input')
Button = ReactBootstrap.Button
Form = require('components/shared/form')

module.exports = React.createClass
  displayName: "SignupMenu"

  render: ->
    <Form className="signup-menu">
      <input label="Email" />
      <input label="Password" />
      <input label="Confirm Password" />
      <input label='I accept the' type= 'checkbox' />
      <a href="/terms-of-use" target="_blank">Terms of Use</a>
      <Button bsStyle='primary' block>Create account</Button>
    </Form>
