UserActions = require('actions/user_actions')
router = require('lib/router')
Form = require('components/shared/form')

module.exports = React.createClass
  displayName: 'ResetPasswordPage'
  propTypes:
    lfe: React.PropTypes.string.isRequired

  handleAfterSave: ->
    flash('Successfully updated password')
    router.visit('/')

  handleSubmit: ->
    UserActions.resetPassword({lfe: @props.lfe})

  render: ->
    <Form className="reset-password-page" onSubmit={@handleSubmit} replaceContent=true afterSave={@handleAfterSave}>
      <h1>Rest Password</h1>
      <input name="password" label="Password" type="password" />
      <input name="confirm_password" label="Confirm Password" type="password" />
      <button>Reset password</button>
    </Form>
