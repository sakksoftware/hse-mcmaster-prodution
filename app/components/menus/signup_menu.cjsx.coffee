Button = ReactBootstrap.Button
Form = require('components/shared/form')
UserActions = require('actions/user_actions')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: "SignupMenu"
  mixins: [TranslationHelper]
  baseTranslation: 'menus.signup'

  propTypes:
    onSignup: React.PropTypes.func.isRequired

  # afterSaveContent: ->
  #   <div>
  #     <h3 className='confirmation-msg'>{@t('confirmation_msg')}</h3>
  #     <small>{@t('did_not_recieve')}<a href="#">{@t('send_again')}</a></small>
  #   </div>

  handleSubmit: (user, success, error)->
    UserActions.createUser(user)
    UserActions.createUser.completed.listen(success)
    UserActions.createUser.failed.listen(error)

  render: ->
    <Form className="signup-menu"
      onSubmit={@handleSubmit} afterSave={@props.onSignup}>
      <input label={@t('email')} name="email" type="email" />
      <input label={@t('password')} name="password" type="password" />
      <input label={@t('confirm_password')} name="confirm_password" type="password" />
      <input label={@t('i_accept')} type='checkbox' name="accept_terms" />
      <a href="/terms" target="_blank">{@t('terms')}</a>
      <button className='btn-primary'>{@t('signup_button')}</button>
    </Form>
