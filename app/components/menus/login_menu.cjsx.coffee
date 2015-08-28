Button = ReactBootstrap.Button
Form = require('components/shared/form')
UserActions = require('actions/user_actions')
TranslationHelper = require('mixins/translation_helper')
UserStore = require('stores/user_store')

module.exports = React.createClass
  displayName: "LoginMenu"

  mixins: [TranslationHelper]
  baseTranslation: 'menus.login'

  propTypes:
    onLogin: React.PropTypes.func.isRequired

  afterSave: (user) ->
    @props.onLogin(user)

  handleSubmit: (user, success, error) ->
    UserActions.loginUser(user)
    UserActions.loginUser.completed.listen(success)
    UserActions.loginUser.failed.listen(error)

  render: ->
    <Form className="login-menu" onSubmit={@handleSubmit} afterSave={@afterSave}>
      <input label={@t('email')} name="email" type="email" />
      <input label={@t('password')} name="password" type="password" />
      <button className="btn-primary">{@t('login_button')}</button>
      <a href="/forgot_password">{@t('forgot_password')}</a>
    </Form>
