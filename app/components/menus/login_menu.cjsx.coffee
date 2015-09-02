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

  componentWillMount: ->
    @unsubscribe = UserStore.listen(@userUpdated)

  componentWillUnmount: ->
    @unsubscribe()

  getInitialState: ->
    UserStore.state

  userUpdated: (state) ->
    @setState(state)

  afterSave: (user) ->
    @props.onLogin(user)

  handleSubmit: (user, success, error) ->
    UserActions.loginUser(user).then(success, error)

  renderErrors: ->
    if @state.errors
      <div className="form-errors">
        {@t('/errors.invalid_login')}
      </div>

  render: ->
    <Form className="login-menu" onSubmit={@handleSubmit} afterSave={@afterSave}>
      {@renderErrors()}
      <input label={@t('email')} name="email" type="email" />
      <input label={@t('password')} name="password" type="password" />
      <button className="btn-primary">{@t('login_button')}</button>
      <a className="btn-forgot-password" href="/forgot_password">{@t('forgot_password')}</a>
    </Form>
