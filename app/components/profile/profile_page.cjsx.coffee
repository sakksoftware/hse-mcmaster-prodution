languages = require('constants/languages')
EditableInformation = require('components/shared/editable_information')
UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'ProfilePage'

  mixins: [TranslationHelper]
  baseTranslation: 'profile_page'

  getInitialState: ->
    UserStore.state

  componentWillMount: ->
    UserActions.loadUser()
    @unsubscribe = UserStore.listen(@updateState)

  componentWillUnmount: ->
    @unsubscribe()

  updateState: (state) ->
    @setState(state)
    if state.errors
      window.flash('error', @t('short_cannot_load_user_profile'))

  updateUser: (user, form)->
    UserActions.updateUser(user)
    unsubscribe = UserActions.updateUser.completed.listen =>
      window.flash 'success', @t('successfully_updated')
      form.toggleReadOnly()
      unsubscribe()

  renderLanguageSelect: ->
    options =
      for language in languages
        <option key="language-#{language.name}" value={language.name}>{language.title}</option>

    <select label={@t('language')} name="language" type="select" className="form-control">
      {options}
    </select>

  render: ->
    # TODO: desktop needs to support columns
    if @state.loaded && !@state.errors
      <div className="profile-page">
        <h1>{@t('my_profile')}</h1>

        <EditableInformation title={@t('account_information')}
          onSubmit={@updateUser}
          object={@state.user}
          editLabel={@t('edit')}
          cancelLabel={@t('cancel')}
        >
          <input label={@t('email')} name="email" type="email" />
          <input label={@t('password')} name="password" type="password" />
          <input label={@t('confirm_password')} name="confirm_password" type="password" />
        </EditableInformation>

        <EditableInformation title={@t('personal_information')}
          onSubmit={@updateUser}
          object={@state.user}
          editLabel={@t('edit')}
          cancelLabel={@t('cancel')}
        >
          <input label={@t('first_name')} name="first_name" />
          <input label={@t('last_name')} name="last_name" />
          <input label={@t('role')} name="role" />
          <input label={@t('country')} name="country" />
          {@renderLanguageSelect()}
        </EditableInformation>
      </div>
    else if @state.errors
      <div className="profile-page">
        {@t('cannot_load_user_profile')}
      </div>
    else
      <div className="profile-page">
        <Loader loaded={false} />
      </div>
