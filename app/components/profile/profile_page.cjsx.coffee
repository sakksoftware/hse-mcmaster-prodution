languages = require('constants/languages')
EditableInformation = require('components/shared/editable_information')

module.exports = React.createClass
  displayName: 'ProfilePage'

  getInitialState: ->
    user:
      first_name: 'Michael'
      last_name: 'Yagudaev'
      email: 'michael@yagudaev.com'
      password: '******'
      confirm_password: '******'
      role: 'Super Hero'
      country: 'Canada'
      language: 'en'

  renderLanguageSelect: ->
    options =
      for language in languages
        <option key="language-#{language.name}" value={language.name}>{language.title}</option>

    <select label="Language" name="language" type="select" className="form-control">
      {options}
    </select>

  render: ->
    <div className="profile-page">
      <h1>My Profile</h1>

      <EditableInformation title="Account Information" object={@state.user}>
        <input label="Email" name="email" type="email" />
        <input label="Password" name="password" type="password" />
        <input label="Confirm Password" name="confirm_password" type="password" />
      </EditableInformation>

      <EditableInformation title="Personal Information" object={@state.user}>
        <input label="First Name" name="first_name" />
        <input label="Last Name" name="last_name" />
        <input label="Role" name="role" />
        <input label="Country" name="country" />
        {@renderLanguageSelect()}
      </EditableInformation>
    </div>
