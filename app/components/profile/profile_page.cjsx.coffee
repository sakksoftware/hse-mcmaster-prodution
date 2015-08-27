languages = require('constants/languages')
EditableInformation = require('components/shared/editable_information')
UserActions = require('actions/user_actions')
UserStore = require('mocks/stores/user_store')

module.exports = React.createClass
  displayName: 'ProfilePage'

  getInitialState: ->
    UserStore.state

  componentWillMount: ->
    UserActions.loadUser()
    UserStore.listen(@updateState)

  updateState: (state) ->
    @setState(state)
    if state.errors
      window.flash('error', 'Cannot load user profile information')

  updateUser: (user, form)->
    UserActions.updateUser(user)
    unsubscribe = UserActions.updateUser.completed.listen =>
      window.flash('success', 'Successfully updated user')
      form.toggleReadOnly()
      unsubscribe()

  renderLanguageSelect: ->
    options =
      for language in languages
        <option key="language-#{language.name}" value={language.name}>{language.title}</option>

    <select label="Language" name="language" type="select" className="form-control">
      {options}
    </select>

  render: ->
    # TODO: desktop needs to support columns
    # TODO: add localization
    if @state.loaded && !@state.errors
      <div className="profile-page">
        <h1>My Profile</h1>

        <EditableInformation title="Account Information" onSubmit={@updateUser} object={@state.user}>
          <input label="Email" name="email" type="email" />
          <input label="Password" name="password" type="password" />
          <input label="Confirm Password" name="confirm_password" type="password" />
        </EditableInformation>

        <EditableInformation title="Personal Information" onSubmit={@updateUser} object={@state.user}>
          <input label="First Name" name="first_name" />
          <input label="Last Name" name="last_name" />
          <input label="Role" name="role" />
          <input label="Country" name="country" />
          {@renderLanguageSelect()}
        </EditableInformation>
      </div>
    else if @state.errors
      <div className="profile-page">
        Opps, couldn't load user profile. Check your interent connection and try again
      </div>
    else
      <div className="profile-page">
        <Loader loaded={false} />
      </div>
