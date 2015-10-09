UserActions = require('actions/user_actions')
# UrlStore = require('stores/url_store')
Form = require('components/shared/form')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'ResetPasswordPage'

  mixins: [TranslationHelper]
  baseTranslation: 'reset_password_page'

  propTypes:
    lfe: React.PropTypes.string.isRequired

  componentWillMount: ->
    params = require('lib/url').params()
    @initiated = params.i
    # TODO: switch to this version when we merge development branch into master
    # @initiated = UrlStore.state.params.i

  handleAfterSave: ->
    router = require('lib/router')
    flash('success', 'Successfully updated password')
    router.visit('/')

  handleSubmit: (formData, success, error) ->
    if formData.confirm_password != formData.password
      formData.errors ||= {}
      formData.errors.confirm_password = @t('/errors.passwords_must_match')
    if _.isEmpty(formData.confirm_password)
      formData.errors ||= {}
      formData.errors.confirm_password = @t('/errors.cant_be_blank')
    if _.isEmpty(formData.password)
      formData.errors ||= {}
      formData.errors.password = @t('/errors.cant_be_blank')

    if formData.errors
      error(responseText: JSON.stringify(formData))
    else
      # TODO: remove this once it is properly implemented in the backend
      formData.px = formData.lfe
      UserActions.resetPassword(formData).then(success, error)

  render: ->
    <Form className="reset-password-page" onSubmit={@handleSubmit} afterSave={@handleAfterSave}>
      <h1>{@t('title')}</h1>
      <input name="lfe" label="lfe" type="hidden" defaultValue={@props.lfe} />
      <input name="i" label="initiated" type="hidden" defaultValue={@initiated} />
      <input name="password" label={@t('password')} type="password" />
      <input name="confirm_password" label={@t('confirm_password')} type="password" />
      <button>{@t('submit')}</button>
    </Form>
